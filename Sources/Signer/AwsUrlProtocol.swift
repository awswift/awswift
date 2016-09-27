import Foundation
import Cryptor

public extension URLSessionConfiguration {
  public class func aws() -> URLSessionConfiguration {
    let config = URLSessionConfiguration.ephemeral
    var protocols = config.protocolClasses
    protocols?.insert(AwsUrlProtocol.self, at: 0)
    config.protocolClasses = protocols
    return config
  }
}

public extension URLRequest {
  public var awsCredentials: AwsCredentials? {
    get {
      return AwsUrlProtocol.property(forKey: AwsUrlProtocol.CredentialsPropertyKey, in: self) as? AwsCredentials
    }
    set(value) {
      let mutable = self as Any as! NSMutableURLRequest
      if let v = value {
        AwsUrlProtocol.setProperty(v, forKey: AwsUrlProtocol.CredentialsPropertyKey, in: mutable)
      } else {
        AwsUrlProtocol.removeProperty(forKey: AwsUrlProtocol.CredentialsPropertyKey, in: mutable)
      }
    }
  }
}

func accumulateStreamIntoData(stream: InputStream) -> Data {
  let size = 1048576
  var buffer = Array<UInt8>(repeating: 0, count: size)
  var data = Data()
  
  stream.open()
  
  while stream.hasBytesAvailable {
    let bytesRead = stream.read(&buffer, maxLength: size)
    data.append(&buffer, count: bytesRead)
  }
  
  return data
}

class AwsUrlProtocol: URLProtocol, NSURLConnectionDelegate, NSURLConnectionDataDelegate {
  static let CredentialsPropertyKey = "AwsCredentialsPropertyKey"
  var connection: NSURLConnection?
  
  override class func canInit(with request: URLRequest) -> Bool {
    if case .nonAws = AwsHostnameType.typeOfUrl(request.url!) {
      return false
    } else {
      return true
    }
  }
  
  override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    return request
  }
  
  override func startLoading() {
    var request = self.request
    
    let date = Date()
    let dateHeader = DateFormatter.awsDateTimeFormatter().string(from: date)
    request.addValue(dateHeader, forHTTPHeaderField: "X-Amz-Date")
    
    let payload: AwsRequestSigner.Payload
    if let s3PayloadHash = request.allHTTPHeaderFields?["x-amz-content-sha256"] {
      let data: Data = CryptoUtils.data(fromHex: s3PayloadHash)
      payload = .sha256(data)
    } else if let stream = request.httpBodyStream {
      payload = .data(accumulateStreamIntoData(stream: stream))
    } else {
      payload = .empty
    }
    
    let creds = request.awsCredentials ?? DefaultChainProvider().provideAwsCredentials()!
    let scope = AwsCredentialsScope(url: request.url!)!
    let signer = AwsRequestSigner(credentials: creds, scope: scope, request: request, payload: payload)
    let auth = signer.authorizationHeader()
    
    request.addValue(auth, forHTTPHeaderField: "Authorization")
    
    connection = NSURLConnection(request: request, delegate: self, startImmediately: true)
  }
  
  func connection(_ connection: NSURLConnection, didFailWithError error: Error) {
    client?.urlProtocol(self, didFailWithError: error)
  }
  
  func connection(_ connection: NSURLConnection, didReceive data: Data) {
    client?.urlProtocol(self, didLoad: data)
  }
  
  func connection(_ connection: NSURLConnection, didReceive response: URLResponse) {
    client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .allowed)
  }
  
  func connectionDidFinishLoading(_ connection: NSURLConnection) {
    client?.urlProtocolDidFinishLoading(self)
  }
  
  override func stopLoading() {
    connection?.cancel()
  }
}
