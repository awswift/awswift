import Foundation

public struct AwsCredentialsScope {
  public let date: Date
  public let region: String
  public let service: String
  
  public init(date: Date, region: String, service: String) {
    self.date = date
    self.region = region
    self.service = service
  }
  
  // TODO: look at https://github.com/aws/aws-sdk-ios/blob/1034a77a77cc7ea5866389275a5105bff074f24f/AWSCore/Service/AWSService.m#L426-L481
  public init?(url: URL) {
    date = Date()
    
    switch AwsHostnameType.typeOfUrl(url) {
    case .regional(let s, let r):
      service = s
      region = r
    case .global(let s):
      service = s
      region = "us-east-1"
    case .nonAws:
      return nil
    }
  }
  
  public func toString() -> String {
    let datefmt = DateFormatter.awsDateFormatter().string(from: date)
    return "\(datefmt)/\(region)/\(service)/aws4_request"
  }
}
