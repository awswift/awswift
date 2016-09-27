import Foundation

public protocol AwsCredentialsProvider {
  func provideAwsCredentials() -> AwsCredentials?
}

public struct DefaultChainProvider: AwsCredentialsProvider {
  public func provideAwsCredentials() -> AwsCredentials? {
    let chain: [AwsCredentialsProvider] = [
      GlobalCredentialsProvider(),
      EnvCredentialsProvider(),
      IniFileCredentialsProvider(),
      InstanceProfileCredentialsProvider()
    ]
    
    for provider in chain {
      if let creds = provider.provideAwsCredentials() {
        return creds
      }
    }
    
    return nil
  }
  
  public init() {
    
  }
}

public struct GlobalCredentialsProvider: AwsCredentialsProvider {
  public func provideAwsCredentials() -> AwsCredentials? {
    return AwsCredentials.sharedCredentials
  }
  
  public init() {
    
  }
}

public struct StaticCredentialsProvider: AwsCredentialsProvider {
  let credentials: AwsCredentials
  
  public func provideAwsCredentials() -> AwsCredentials? {
    return credentials
  }
  
  public init(credentials: AwsCredentials) {
    self.credentials = credentials
  }
}

public struct EnvCredentialsProvider: AwsCredentialsProvider {
  public func provideAwsCredentials() -> AwsCredentials? {
    let env = ProcessInfo.processInfo.environment
    let aki = env["AWS_ACCESS_KEY_ID"]
    let sak = env["AWS_SECRET_ACCESS_KEY"]
    let tok = env["AWS_SESSION_TOKEN"]
    
    if aki != nil && sak != nil {
      return AwsCredentials(accessKeyId: aki!, secretAccessKey: sak!, sessionToken: tok)
    } else {
      return nil
    }
  }
  
  public init() {
    
  }
}

public struct IniFileCredentialsProvider: AwsCredentialsProvider {
  public func provideAwsCredentials() -> AwsCredentials? {
    // https://github.com/aws/aws-sdk-ruby/blob/master/aws-sdk-core/lib/aws-sdk-core/shared_credentials.rb
    fatalError("Not implemented yet")
  }
  
  public init() {
    
  }
}

public struct InstanceProfileCredentialsProvider: AwsCredentialsProvider {
  public func provideAwsCredentials() -> AwsCredentials? {
    // https://github.com/aws/aws-sdk-ruby/blob/master/aws-sdk-core/lib/aws-sdk-core/instance_profile_credentials.rb
    fatalError("Not implemented yet")
  }
  
  public init() {
    
  }
}
