import Foundation
import URITemplate
#if !os(Linux)
    import PromiseKit
#endif
import Signer

extension Optional {
    func flatMapNoNulls<U>(_ transform: (Wrapped) throws -> U?) rethrows -> U? {
        return try flatMap { val in
            if val is NSNull  {
                return nil
            } else {
                return try transform(val)
            }
        }
    }
}

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

struct ApiCallTask<T> {
    let handler: (@escaping (T?, Error?) -> ()) -> ()
    
    func async(_ completionHandler: @escaping (_: T?, _: Error?) -> ()) {
        handler(completionHandler)
    }
    
    #if !os(Linux)
    func promise() -> Promise<T> {
        return wrap { async($0) }
    }
    #endif
    
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
        } else if let ret = ret {
            return ret
        } else {
            fatalError()
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

protocol AwswiftSerializable {
    func serialize() -> SerializedForm
}
protocol AwswiftDeserializable {
    static func deserialize(response: HTTPURLResponse, body: Any?) -> Self
    static func deserializableBody(data: Data) -> DeserializableBody
}

struct RestJsonRequest {
    let method: String
    let relativeUrl: String
    let expectedStatus: Int?
    let headers: [String: String]
    let uriSubs: [String: String]
    let body: Any?
}

protocol RestJsonSerializable {
    func restJsonSerialize() -> Any?
//    func httpMethod() -> String
//    func relativeUriPattern() -> String
//    func expectedStatus() -> Int?
//    func headers() -> [String: String]
//    func uriParts() -> [String: String]
//    func body() -> Any?
}

func RestJsonRequestSerializer(input: RestJsonRequest, baseURL: URL) -> URLRequest {
    let uriSubs = Dictionary<String, String>.filterNils(input.uriSubs)
    let template = URITemplate(template: input.relativeUrl)
    let expandedString = template.expand(uriSubs)

    let url = URL(string: expandedString)!
    var req = URLRequest(url: url)
    req.httpMethod = input.method
    
    for (field, value) in input.headers {
        req.addValue(value, forHTTPHeaderField: field)
    }
    
    if let body = input.body, let json = try? JSONSerialization.data(withJSONObject: body, options: []) {
        req.httpBody = json
    }
    
    return req
}

extension AwswiftDeserializable {
    static func deserializableBody(data: Data) -> DeserializableBody {
        fatalError()
    }
}

struct AwsApiVoidOutput {
    static func deserialize(response: HTTPURLResponse, body: Any?) -> AwsApiVoidOutput {
        return AwsApiVoidOutput()
    }
}

struct AwsApiVoidInput: AwswiftSerializable {
    func serialize() -> SerializedForm {
        return SerializedForm(uri: [:], queryString: [:], header: [:], body: .empty)
    }
}

struct UnexpectedStatusResponse: Error {
    let response: HTTPURLResponse
    let data: Data?
}

func dateAndSignRequest(request: URLRequest, credentials: AwsCredentials, scope: AwsCredentialsScope) -> URLRequest {
    var req = request
    
    let payload: AwsRequestSigner.Payload
    if let data = req.httpBody {
        payload = .data(data)
    } else {
        payload = .empty
    }
    
    let date = Date()
    let dateHeader = DateFormatter.awsDateTimeFormatter().string(from: date)
    req.addValue(dateHeader, forHTTPHeaderField: "X-Amz-Date")
    
    let signer = AwsRequestSigner(credentials: credentials, scope: scope, request: req, payload: payload)
    let auth = signer.authorizationHeader()
    req.addValue(auth, forHTTPHeaderField: "Authorization")
    
    return req
}

func awsApiCallTask<I: AwswiftSerializable, O: AwswiftDeserializable>(session: URLSession, credentials: AwsCredentials, scope: AwsCredentialsScope, queue: DispatchQueue, urlString: String, httpMethod: String, expectedStatus: Int?, input: I, completionHandler: @escaping (_: O?, _: Error?) -> ()) -> URLSessionTask {
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
            let http = response as! HTTPURLResponse
            if error != nil {
                completionHandler(nil, error)
            } else if expectedStatus == nil || http.statusCode == expectedStatus {
                let body = O.deserializableBody(data: data!)
                let ret = O.deserialize(response: http, body: body)
                completionHandler(ret, nil)
            } else {
                completionHandler(nil, UnexpectedStatusResponse(response: http, data: data))
            }
        }
    })
}
