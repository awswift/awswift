import XCTest
@testable import Awswift
import Signer

class S3Tests: XCTestCase {
  func testS3() throws {
    AwsCredentials.sharedCredentials = AwsCredentials(
      accessKeyId: "",
      secretAccessKey: "",
      sessionToken: nil
    )
    
    let client = S3.Client(region: "us-east-1")
    let input = S3.ListObjectsV2Request(bucket: "iconicalapp.com", maxKeys: nil, startAfter: nil, continuationToken: nil, requestPayer: nil, prefix: nil, fetchOwner: nil, delimiter: nil, encodingType: nil)
    let response = try client.listObjectsV2(input: input).sync()
    dump(response)
  }
  
  static var allTests : [(String, (S3Tests) -> () throws -> Void)] {
    return [
      //            ("testExample", testExample),
    ]
  }
}
