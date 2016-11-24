import XCTest
@testable import Signer

class AwsHostnameTypeTests: XCTestCase {
  
  func testRegionalService() {
    let url = URL(string: "https://dynamodb.ap-southeast-2.amazonaws.com")!
    let scope = AwsCredentialsScope(url: url)
    XCTAssertNotNil(scope)
    XCTAssertEqual(scope!.service, "dynamodb")
    XCTAssertEqual(scope!.region, "ap-southeast-2")
  }
  
  func testGlobalService() {
    let url = URL(string: "https://s3.amazonaws.com")!
    let scope = AwsCredentialsScope(url: url)
    XCTAssertNotNil(scope)
    XCTAssertEqual(scope!.service, "s3")
    XCTAssertEqual(scope!.region, "us-east-1")
  }
  
  func testS3External1() {
    let url = URL(string: "https://s3-external-1.amazonaws.com")!
    let scope = AwsCredentialsScope(url: url)
    XCTAssertNotNil(scope)
    XCTAssertEqual(scope!.service, "s3")
    XCTAssertEqual(scope!.region, "us-east-1")
  }
  
  func testOldS3Format() {
    let url = URL(string: "https://s3-ap-southeast-2.amazonaws.com")!
    let scope = AwsCredentialsScope(url: url)
    XCTAssertNotNil(scope)
    XCTAssertEqual(scope!.service, "s3")
    XCTAssertEqual(scope!.region, "ap-southeast-2")
  }
  
  func testOldS3WebsiteFormat() {
    let url = URL(string: "https://bucket-name.s3-ap-southeast-2.amazonaws.com")!
    let scope = AwsCredentialsScope(url: url)
    XCTAssertNotNil(scope)
    XCTAssertEqual(scope!.service, "s3")
    XCTAssertEqual(scope!.region, "ap-southeast-2")
  }
  
  func testNewS3Format() {
    let url = URL(string: "https://s3.us-east-2.amazonaws.com")!
    let scope = AwsCredentialsScope(url: url)
    XCTAssertNotNil(scope)
    XCTAssertEqual(scope!.service, "s3")
    XCTAssertEqual(scope!.region, "us-east-2")
  }
  
  func testNewS3WebsiteFormat() {
    let url = URL(string: "https://bucket-name.s3.us-east-2.amazonaws.com")!
    let scope = AwsCredentialsScope(url: url)
    XCTAssertNotNil(scope)
    XCTAssertEqual(scope!.service, "s3")
    XCTAssertEqual(scope!.region, "us-east-2")
  }
  
  func testExecuteApiSpecialCase() {
    let url = URL(string: "https://iot.ap-southeast-2.amazonaws.com")!
    let scope = AwsCredentialsScope(url: url)
    XCTAssertNotNil(scope)
    XCTAssertEqual(scope!.service, "execute-api")
    XCTAssertEqual(scope!.region, "ap-southeast-2")
  }
  
  func testIoTDataApiSpecialCase() {
    let url = URL(string: "https://data.iot.ap-southeast-2.amazonaws.com")!
    let scope = AwsCredentialsScope(url: url)
    XCTAssertNotNil(scope)
    XCTAssertEqual(scope!.service, "iotdata")
    XCTAssertEqual(scope!.region, "ap-southeast-2")
  }
  
  static var allTests : [(String, (AwsCredentialsScopeTests) -> () throws -> Void)] {
    return [
      //            ("testExample", testExample),
    ]
  }
}
