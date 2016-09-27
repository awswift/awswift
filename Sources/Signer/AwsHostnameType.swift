import Foundation

enum AwsHostnameType {
  case regional(service: String, region: String)
  case global(service: String)
  case nonAws
  
  static func typeOfUrl(_ url: URL) -> AwsHostnameType {
    let host = url.host! as NSString
    let hostRange = NSRange(location: 0, length: host.length)
    
    let r = { str in try! NSRegularExpression(pattern: str, options: []) }
    let match: (NSRegularExpression) -> (NSTextCheckingResult?) = { regex in regex.firstMatch(in: url.host!, options: [], range: hostRange) }
    
    let regionalRegex = r("^([a-zA-Z0-9-]+)\\.([a-zA-Z0-9-]+)\\.amazonaws.com(?:.cn)?$")
    let s3Regex = r("^(?:(?:[a-zA-Z0-9-]+)\\.)?s3(?:\\.|-)([a-zA-Z0-9-]+)\\.amazonaws.com(?:.cn)?$") // TODO: support dualstack
    let globalRegex = r("^([a-zA-Z0-9-]+)\\.amazonaws.com(?:.cn)?$")
    let iotDataApiRegex = r("^(?:[a-zA-Z0-9-]+)\\.iot\\.([a-zA-Z0-9-]+)\\.amazonaws.com(?:.cn)?$")
    
    let oddServices = [
      "iot": "execute-api",
    ]
    
    if let result = match(s3Regex) {
      let region = host.substring(with: result.rangeAt(1))
      if region == "external-1" {
        return .regional(service: "s3", region: "us-east-1")
      } else {
        return .regional(service: "s3", region: region)
      }
    } else if let result = match(regionalRegex) {
      let subdomain = host.substring(with: result.rangeAt(1))
      let service = oddServices[subdomain] ?? subdomain
      let region = host.substring(with: result.rangeAt(2))
      return .regional(service: service, region: region)
    } else if let result = match(globalRegex) {
      let service = host.substring(with: result.rangeAt(1))
      return .global(service: service)
    } else if let result = match(iotDataApiRegex) {
      let region = host.substring(with: result.rangeAt(1))
      return .regional(service: "iotdata", region: region)
    } else {
      return .nonAws
    }
  }
}
