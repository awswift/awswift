import Foundation
import URITemplate
#if !os(Linux)
    import PromiseKit
#endif
import Signer
import Cryptor

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

indirect enum RestJsonFieldValue {
    case string(String)
    case numberI(Int)
    case date(Date)
    case data(Data)
    case bool(Bool)
    case array([RestJsonFieldValue])
    case object([RestJsonField])
    
    func stringValue() -> String {
        switch self {
        case .string(let s): return s
        default: fatalError()
        }
    }
    //case null
}

struct RestJsonField {
    enum Location {
        case body
        case header
        case statusCode
        case uri
        case querystring
    }
    
    let name: String
    let location: Location
    let value: RestJsonFieldValue?
}

struct RestJsonRequest {
    let method: String
    let relativeUrl: String
    let expectedStatus: Int?
    let fields: [RestJsonField]
}

protocol RestJsonSerializable {
    func restJsonSerialize() -> RestJsonFieldValue
}

enum QueryFieldValue {
    case string(String)
    case array([QueryFieldValue])
    case object([String: QueryFieldValue?])
    
    func serialize(stack: [Any]) -> [URLQueryItem] {
        let name = stack.map { "\($0)" }.joined(separator: ".")
        
        switch self {
        case .string(let s): return [URLQueryItem(name: name, value: s)]
        case .array(let arr):
            return arr.enumerated().flatMap { (offset, value) -> [URLQueryItem] in
                var newstack = stack
                newstack.append(contentsOf: ["member", offset + 1])
                return value.serialize(stack: newstack)
            }
        case .object(let dict):
            return dict.flatMap { (key, value) -> [URLQueryItem] in
                var newstack = stack
                newstack.append(key)
                return value?.serialize(stack: newstack) ?? []
            }
        }
    }
}

struct QueryRequest {
    let action: String
    let method: String
    let relativeUrl: String
    let params: QueryFieldValue
}

protocol QuerySerializable {
    func querySerialize() -> QueryFieldValue
}

func QueryRequestSerializer(input: QueryRequest, baseURL: URL) -> URLRequest {
    var queryItems = input.params.serialize(stack: [])
    queryItems.append(URLQueryItem(name: "Action", value: input.action))
    
    let url = URL(string: "/", relativeTo: baseURL)!
    var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
    components.queryItems = queryItems
    
    var req = URLRequest(url: components.url!)
    req.httpMethod = input.method
    
    return req
}

func RestXmlRequestSerializer(input: QueryRequest, baseURL: URL) -> URLRequest {
    let queryItems = input.params.serialize(stack: [])
    let uriSubs = Dictionary(queryItems.map { ($0.name, $0.value!) })
    
    let template = URITemplate(template: input.relativeUrl)
    let expandedString = template.expand(uriSubs)
    
    let url = URL(string: expandedString, relativeTo: baseURL)!
    var req = URLRequest(url: url)
    req.httpMethod = input.method
    
    return req
}

func RestJsonRequestSerializer(input: RestJsonRequest, baseURL: URL) -> URLRequest {
    // TODO: recurse into sub structs
    let byLoc = { (loc: RestJsonField.Location) in input.fields.filter { $0.location == loc } }
    let headers = byLoc(.header)
    let body = byLoc(.body)
    
    let uriFields = (byLoc(.uri) + byLoc(.querystring)).filter { $0.value != nil }
    let uriSubs = Dictionary(uriFields.map { ($0.name, $0.value!.stringValue()) })
    
    let template = URITemplate(template: input.relativeUrl)
    let expandedString = template.expand(uriSubs)

    let url = URL(string: expandedString, relativeTo: baseURL)!
    var req = URLRequest(url: url)
    req.httpMethod = input.method
    
    for field in headers {
        field.value.map { req.addValue($0.stringValue(), forHTTPHeaderField: field.name) }
    }
    
//    if let json = try? JSONSerialization.data(withJSONObject: body, options: []) {
//        req.httpBody = json
//    }
    
    return req
}

extension AwswiftDeserializable {
    static func deserializableBody(data: Data) -> DeserializableBody {
        fatalError()
    }
}

struct AwsApiVoidOutput: AwswiftDeserializable {
    static func deserialize(response: HTTPURLResponse, body: Any?) -> AwsApiVoidOutput {
        return AwsApiVoidOutput()
    }
}

struct AwsApiVoidInput: AwswiftSerializable, QuerySerializable {
    func serialize() -> SerializedForm {
        return SerializedForm(uri: [:], queryString: [:], header: [:], body: .empty)
    }
    
    
    func querySerialize() -> QueryFieldValue {
        return .string("")
    }
}

struct UnexpectedStatusResponse: Error {
    let response: HTTPURLResponse
    let data: Data?
}

func dateAndSignRequest(request: URLRequest, credentials: AwsCredentials, scope: AwsCredentialsScope) -> URLRequest {
    var req = request
    
    let payload: AwsRequestSigner.Payload
    let payloadHash: String
    
    if let data = req.httpBody {
        payload = .data(data)
        let bytes = Digest(using: .sha256).update(data: data)!.final()
        payloadHash = CryptoUtils.hexString(from: bytes)
    } else {
        payload = .empty
        payloadHash = "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855" // sha256 of empty string
    }
    
    let date = Date()
    let dateHeader = DateFormatter.awsDateTimeFormatter().string(from: date)
    req.addValue(dateHeader, forHTTPHeaderField: "X-Amz-Date")
    
    // NOTE: the presence of the following header is _required_ for S3, but rather
    // than special-casing the S3 client, i guess it can't hurt to always include it?
    // TODO: revisit this poor decision later
    req.addValue(payloadHash, forHTTPHeaderField: "X-Amz-Content-Sha256")
    
    let signer = AwsRequestSigner(credentials: credentials, scope: scope, request: req, payload: payload)
    let auth = signer.authorizationHeader()
    req.addValue(auth, forHTTPHeaderField: "Authorization")
    
    return req
}
