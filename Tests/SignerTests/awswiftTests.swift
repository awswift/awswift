import XCTest
@testable import Signer

class awswiftTests: XCTestCase {
  var signer: AwsRequestSigner!
  
  override func setUp() {
    let url = URL(string: "https://iam.amazonaws.com/?Action=ListUsers&Version=2010-05-08")!
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    let headers = [
      "Content-Type": "application/x-www-form-urlencoded; charset=utf-8",
      "X-Amz-Date": "20150830T123600Z"
    ]
    
    for (key, val) in headers {
      request.addValue(val, forHTTPHeaderField: key)
    }
    
    let credentials = AwsCredentials(accessKeyId: "AKIDEXAMPLE", secretAccessKey: "wJalrXUtnFEMI/K7MDENG+bPxRfiCYEXAMPLEKEY", sessionToken: nil)
    let scope = AwsCredentialsScope(date: Date(timeIntervalSince1970: 1440938160), region: "us-east-1", service: "iam")
    
    signer = AwsRequestSigner(credentials: credentials, scope: scope, request: request, payload: .empty)
  }
  
  func testAuthorizationHeader() {
    XCTAssertEqual(signer.authorizationHeader(), "AWS4-HMAC-SHA256 Credential=AKIDEXAMPLE/20150830/us-east-1/iam/aws4_request, SignedHeaders=content-type;host;x-amz-date, Signature=5d672d79c15b13162d9279b0855cfba6789a8edb4c82c400e06b5924a6f2b5d7")
  }
  
  func testV4SignableString() {
    XCTAssertEqual(signer.signableString(),
                   "AWS4-HMAC-SHA256\n" +
                    "20150830T123600Z\n" +
                    "20150830/us-east-1/iam/aws4_request\n" +
      "f536975d06c0309214f805bb90ccff089219ecd68b2577efef23edd43b7e1a59")
  }
  
  func testV4CanonicalQuery() {
    XCTAssertEqual(signer.canonicalQuery(),
                   "GET\n" +
                    "/\n" +
                    "Action=ListUsers&Version=2010-05-08\n" +
                    "content-type:application/x-www-form-urlencoded; charset=utf-8\n" +
                    "host:iam.amazonaws.com\n" +
                    "x-amz-date:20150830T123600Z\n" +
                    "\n" +
                    "content-type;host;x-amz-date\n" +
      "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855")
  }
  
  func testV4CanonicalQueryWithTrailingSlash() {
    let url = URL(string: "https://iam.amazonaws.com/SomePathWithTrailingSlash/?Action=ListUsers&Version=2010-05-08")!
    let request = URLRequest(url: url)
    
    let credentials = AwsCredentials(accessKeyId: "AKIDEXAMPLE", secretAccessKey: "wJalrXUtnFEMI/K7MDENG+bPxRfiCYEXAMPLEKEY", sessionToken: nil)
    let scope = AwsCredentialsScope(date: Date(timeIntervalSince1970: 1440938160), region: "us-east-1", service: "iam")
    let signer = AwsRequestSigner(credentials: credentials, scope: scope, request: request, payload: .empty)
    
    XCTAssertEqual(signer.canonicalQuery(),
     "GET\n" +
      "/SomePathWithTrailingSlash/\n" +
      "Action=ListUsers&Version=2010-05-08\n" +
      "host:iam.amazonaws.com\n" +
      "\n" +
      "host\n" +
      "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855")
  }
  
  /*func testShiz() {
    let testsDir = "/Users/aidan.steele/Downloads/aws4_testsuite/aws4_testsuite/"
    let tests = try! FileManager.default.contentsOfDirectory(atPath: testsDir)
    
    for test in tests {
      let testFilePrefix = testsDir + test + "/" + "test"
      let req =   try! String(contentsOfFile: testFilePrefix + ".req")
      let creq =  try! String(contentsOfFile: testFilePrefix + ".creq")
      let sreq =  try! String(contentsOfFile: testFilePrefix + ".sreq")
      let sts =   try! String(contentsOfFile: testFilePrefix + ".sts")
      let authz = try! String(contentsOfFile: testFilePrefix + ".authz")
      
      //let request = URLRequest(url: <#T##URL#>)
      
      print(test)
    }
  }*/
  
  static var allTests : [(String, (awswiftTests) -> () throws -> Void)] {
    return [
      //            ("testExample", testExample),
    ]
  }
}
