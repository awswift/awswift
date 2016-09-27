import Foundation

public extension DateFormatter {
  public static let AwsDefaultDateFormat = "yyyyMMdd"
  public static let AwsDefaultDateTimeFormat = "yyyyMMdd'T'HHmmss'Z'"
  
  public static func awsDateFormatter() -> DateFormatter {
    let fmt = DateFormatter()
    fmt.dateFormat = AwsDefaultDateFormat
    fmt.timeZone = TimeZone(secondsFromGMT: 0)
    return fmt
  }
  
  public static func awsDateTimeFormatter() -> DateFormatter {
    let fmt = DateFormatter()
    fmt.dateFormat = AwsDefaultDateTimeFormat
    fmt.timeZone = TimeZone(secondsFromGMT: 0)
    return fmt
  }
}
