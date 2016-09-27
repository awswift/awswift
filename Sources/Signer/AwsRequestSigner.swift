import Foundation
import Cryptor

extension Data {
  func toHex() -> String {
    let bytes = self.withUnsafeBytes { [UInt8](UnsafeBufferPointer(start: $0, count: self.count)) }
    return CryptoUtils.hexString(from: bytes)
  }
  
  func hmac256(key: Data) -> Data {
    let hmacBytes = HMAC(using: .sha256, key: key).update(data: self)?.final()
    return CryptoUtils.data(from: hmacBytes!)
  }
}

public struct AwsRequestSigner {
  typealias CanonicalHeader = (key: String, val: String)
  
  static let AwsDefaultAlgorithmv4 = "AWS4-HMAC-SHA256"
  
  public let credentials: AwsCredentials
  public let scope: AwsCredentialsScope
  public let request: URLRequest
  public let payload: Payload
  
  public enum Payload {
    case data(Data)
    case sha256(Data)
    case empty
  }
  
  public init(credentials: AwsCredentials, scope: AwsCredentialsScope, request: URLRequest, payload: Payload) {
    self.credentials = credentials
    self.scope = scope
    self.request = request
    self.payload = payload
  }
  
  func signingKey() -> Data {
    let date = DateFormatter.awsDateFormatter().string(from: scope.date)
    let k1Str = "AWS4" + credentials.secretAccessKey
    
    let strHmac = { (key: Data, str: String) -> Data in
      return str.data(using: .utf8)!.hmac256(key: key)
    }
    
    let k1 = k1Str.data(using: .utf8)!
    let k2 = strHmac(k1, date)
    let k3 = strHmac(k2, scope.region)
    let k4 = strHmac(k3, scope.service)
    return strHmac(k4, "aws4_request")
  }
  
  func canonicalHeaders() -> [CanonicalHeader] {
    let regex = try! NSRegularExpression(pattern: "\\s+", options: [])
    
    var headers: [CanonicalHeader] = request.allHTTPHeaderFields?.map({ (key, val) in
      let trimmedValue = val.trimmingCharacters(in: CharacterSet.whitespaces)
      let range = NSRange(location: 0, length: trimmedValue.characters.count)
      let zappedValue = regex.stringByReplacingMatches(in: trimmedValue, options: [], range: range, withTemplate: " ")
      return (key.lowercased(), zappedValue)
    }) ?? []
    
    headers.append(("host", request.url!.host!))
    headers.sort { $0.key < $1.key }
    
    return headers
  }
  
  func canonicalQuery() -> String {
    let canonicalHeaders = self.canonicalHeaders()
    let signedHeaders = canonicalHeaders.map { $0.key }.joined(separator: ";")

    let bodyHash: [UInt8]
    
    switch payload {
    case .data(let data):
      bodyHash = Digest(using: .sha256).update(data: data)!.final()
    case .sha256(let hash):
      bodyHash = hash.withUnsafeBytes { [UInt8](UnsafeBufferPointer(start: $0, count: hash.count)) }
    case .empty:
      bodyHash = Digest(using: .sha256).update(data: Data())!.final()
    }
    
    let bodyHashHex = CryptoUtils.hexString(from: bodyHash)
    let sortedQuery = request.url?.query?.components(separatedBy: "&").sorted().joined(separator: "&") ?? ""
    let headers = canonicalHeaders.map { "\($0.key):\($0.val)" }.joined(separator: "\n")
    
    // NSURL.path() strips trailing slashes, which makes bytewise hashing not-fun
    let path = URLComponents(url: request.url!, resolvingAgainstBaseURL: true)!.path
    
    return [
      request.httpMethod!.uppercased(),
      path,
      sortedQuery,
      headers,
      "",
      signedHeaders,
      bodyHashHex
      ].joined(separator: "\n")
  }
  
  func signableString() -> String {
    let timestamp = request.value(forHTTPHeaderField: "X-Amz-Date") ?? request.value(forHTTPHeaderField: "Date")
    let c = canonicalQuery()
    print("canon: \(c)")
    let canonicalQueryBytes = Digest(using: .sha256).update(string: c)?.final()
    let canonicalQueryHex = CryptoUtils.hexString(from: canonicalQueryBytes!)
    
    return [
      AwsRequestSigner.AwsDefaultAlgorithmv4,
      timestamp!,
      scope.toString(),
      canonicalQueryHex
      ].joined(separator: "\n")
  }
  
  func signature() -> Data {
    let signable = signableString()
    print("signable: \(signable)")
    let key = signingKey()
    return signable.data(using: .utf8)!.hmac256(key: key)
  }
  
  public func authorizationHeader() -> String {
    let canonicalHeaders = self.canonicalHeaders()
    let signedHeaders = canonicalHeaders.map { $0.key }.joined(separator: ";")
    let signatureHex = self.signature().toHex()
    
    return "\(AwsRequestSigner.AwsDefaultAlgorithmv4) Credential=\(credentials.accessKeyId)/\(scope.toString()), SignedHeaders=\(signedHeaders), Signature=\(signatureHex)"
  }
  
  
}

