import Foundation

public struct AwsCredentials {
  static public var sharedCredentials: AwsCredentials?
  
  public let accessKeyId: String
  public let secretAccessKey: String
  public let sessionToken: String?
  
  public init(accessKeyId: String, secretAccessKey: String, sessionToken: String?) {
    self.accessKeyId = accessKeyId
    self.secretAccessKey = secretAccessKey
    self.sessionToken = sessionToken
  }
}


