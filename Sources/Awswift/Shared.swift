import Foundation
import URITemplate
import PromiseKit
import Signer

extension Dictionary {
  init<S: Sequence>(_ seq: S) where S.Iterator.Element == Element {
    self.init()
    self.merge(seq)
  }
  
  mutating func merge<S: Sequence>(_ seq: S) where S.Iterator.Element == Element {
    var gen = seq.makeIterator()
    while let (key, value) = gen.next() {
      self[key] = value
    }
  }
}
struct ApiCallTask<T> {
  let handler: (@escaping (T?, Error?) -> ()) -> ()
  
  func async(_ completionHandler: @escaping (_: T?, _: Error?) -> ()) {
    handler(completionHandler)
  }
  
  func promise() -> Promise<T> {
    return wrap { async($0) }
  }
  
  func sync() throws -> T {
    let sema = DispatchSemaphore(value: 0)
    var ret: T? = nil
    var err: Error? = nil
    
    async { (output, error) in
      ret = output
      err = error
      sema.signal()
    }
    
    sema.wait()
    
    if let err = err {
      throw err
    } else {
      return ret!
    }
  }
  
  init(_ handler: @escaping (@escaping (T?, Error?) -> ()) -> ()) {
    self.handler = handler
  }
}

struct SerializedForm {
  enum Body {
    case json(Any)
    case raw(Data)
    case empty
  }
  
  let uri: [String: String?]
  let queryString: [String: String?]
  let header: [String: String?]
  let body: Body
}
protocol RestJsonSerializable {
  func serialize() -> SerializedForm
}
protocol RestJsonDeserializable {
  static func deserialize(response: HTTPURLResponse, json: Any) -> Self
}
extension Array where Element: RestJsonDeserializable {
  static func deserialize(response: HTTPURLResponse, json: Any) -> [Element] {
    let arr = json as! [Any]
    return arr.map { Element.deserialize(response: response, json: $0) }
  }
}
extension Dictionary where Key: RestJsonDeserializable {
  static func deserialize(response: HTTPURLResponse, json: Any) -> [Key: Value] {
    let dict = json as! [Key: Value]
    return Dictionary(dict.map { (key: Key.deserialize(response: response, json: $0), value: $1) })
  }
}
extension String: RestJsonDeserializable {
  static func deserialize(response: HTTPURLResponse, json: Any) -> String {
    return json as! String
  }
}
extension Int: RestJsonDeserializable {
  static func deserialize(response: HTTPURLResponse, json: Any) -> Int {
    return json as! Int
  }
}

extension Float: RestJsonDeserializable {
  static func deserialize(response: HTTPURLResponse, json: Any) -> Float {
    return json as! Float
  }
}
extension Double: RestJsonDeserializable {
  static func deserialize(response: HTTPURLResponse, json: Any) -> Double {
    return json as! Double
  }
}
extension Bool: RestJsonDeserializable {
  static func deserialize(response: HTTPURLResponse, json: Any) -> Bool {
    return json as! Bool
  }
}
extension Date: RestJsonDeserializable {
  static func deserialize(response: HTTPURLResponse, json: Any) -> Date {
    return Date()
  }
}
extension Data: RestJsonDeserializable {
  static func deserialize(response: HTTPURLResponse, json: Any) -> Data {
    let str = json as! String
    return str.data(using: .utf8)!
  }
}
struct AwsApiVoidOutput: RestJsonDeserializable {
  static func deserialize(response: HTTPURLResponse, json: Any) -> AwsApiVoidOutput {
    return AwsApiVoidOutput()
  }
}

struct AwsApiVoidInput: RestJsonSerializable {
  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .empty)
  }
}
extension Dictionary {
  static func filterNils<K, V>(_ dict: [K: V?]) -> [K: V] {
    var outdict = Dictionary<K, V>()
    for (k, v) in dict {
      if let val = v {
        outdict[k] = val
      }
    }
    return outdict
  }
}

func awsApiCallTask<I: RestJsonSerializable, O: RestJsonDeserializable>(session: URLSession, credentials: AwsCredentials, scope: AwsCredentialsScope, queue: DispatchQueue, urlString: String, httpMethod: String, expectedStatus: Int?, input: I, completionHandler: @escaping (_: O?, _: Error?) -> ()) -> URLSessionTask {
  let serialized = input.serialize()
  
  let uriSubs = Dictionary<String, String>.filterNils(serialized.uri)
  let template = URITemplate(template: urlString)
  let expandedString = template.expand(uriSubs)
  
  var urlComponents = URLComponents(string: expandedString)!
  let queryItems = Dictionary<String, String>.filterNils(serialized.queryString).map { URLQueryItem(name: $0, value: $1) }
  if queryItems.count > 0 { urlComponents.queryItems = queryItems } 
  var request = URLRequest(url: urlComponents.url!)
  request.httpMethod = httpMethod
  
  Dictionary<String, String>.filterNils(serialized.header).forEach { (field, value) in
    request.addValue(value, forHTTPHeaderField: field)
  }
  
  let payload: AwsRequestSigner.Payload
    switch serialized.body {
    case .json(let json):
      let data = try! JSONSerialization.data(withJSONObject: json, options: [])
      request.httpBody = data
      payload = .data(data)
    case .raw(let data):
      request.httpBody =  data
      payload = .data(data)
    case .empty:
      payload = .empty
    }
  
  let date = Date()
  let dateHeader = DateFormatter.awsDateTimeFormatter().string(from: date)
  request.addValue(dateHeader, forHTTPHeaderField: "X-Amz-Date")

  let signer = AwsRequestSigner(credentials: credentials, scope: scope, request: request, payload: payload)
  let auth = signer.authorizationHeader()
  request.addValue(auth, forHTTPHeaderField: "Authorization")
  request.addValue("e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", forHTTPHeaderField: "x-amz-content-sha256")
  
  return session.dataTask(with: request, completionHandler: { (data, response, error) in
    queue.async {
      if error != nil {
        completionHandler(nil, error)
      } else if let http = response as? HTTPURLResponse, http.statusCode == expectedStatus {
        let json = try! JSONSerialization.jsonObject(with: data!, options: [])
        let ret = O.deserialize(response: http, json: json)
        completionHandler(ret, nil)
      } else {
        completionHandler(nil, nil)
      }
    }
  })
}
