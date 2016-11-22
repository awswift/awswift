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

enum DeserializableBody {
  case json(Any)
  case xml(XMLNode)
}

protocol RestJsonSerializable {
  func serialize() -> SerializedForm
}
protocol RestJsonDeserializable {
  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Self
}
extension Array where Element: RestJsonDeserializable {
  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> [Element] {
    switch body {
    case .json(let json):
      let arr = json as! [Any]
      return arr.map { Element.deserialize(response: response, body: .json($0)) }
    case .xml(let node):
      fatalError()
    }
    
  }
}
extension Dictionary where Key: RestJsonDeserializable {
  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> [Key: Value] {
    switch body {
    case .json(let json):
      let dict = json as! [Key: Value]
      return Dictionary(dict.map { (key: Key.deserialize(response: response, body: .json($0)), value: $1) })
    case .xml(let node):
      fatalError()
    }
    
  }
}
extension String: RestJsonDeserializable {
  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> String {
    switch body {
    case .json(let json): return json as! String
    case .xml(let node): fatalError()
    }
  }
}
extension Int: RestJsonDeserializable {
  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Int {
    switch body {
    case .json(let json): return json as! Int
    case .xml(let node): fatalError()
    }
  }
}

extension Float: RestJsonDeserializable {
  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Float {
    switch body {
    case .json(let json): return json as! Float
    case .xml(let node): fatalError()
    }
  }
}
extension Double: RestJsonDeserializable {
  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Double {
    switch body {
    case .json(let json): return json as! Double
    case .xml(let node): fatalError()
    }
  }
}
extension Bool: RestJsonDeserializable {
  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Bool {
    switch body {
    case .json(let json): return json as! Bool
    case .xml(let node): fatalError()
    }
  }
}
extension Date: RestJsonDeserializable {
  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Date {
    return Date()
  }
}
extension Data: RestJsonDeserializable {
  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Data {
    switch body {
    case .json(let json): return (json as! String).data(using: .utf8)!
    case .xml(let node): fatalError()
    }
  }
}
struct AwsApiVoidOutput: RestJsonDeserializable {
  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> AwsApiVoidOutput {
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
        let ret = O.deserialize(response: http, body: .json(json))
        completionHandler(ret, nil)
      } else {
        completionHandler(nil, nil)
      }
    }
  })
}
