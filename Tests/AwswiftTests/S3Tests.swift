import XCTest
@testable import Awswift
import Signer

class S3Tests: XCTestCase {
  func testS3() throws {
    
    let client = S3.Client(region: "us-east-1")
    let input = S3.ListObjectsV2Request(bucket: "iconicalpp.com", continuationToken: nil, delimiter: nil, encodingType: nil, fetchOwner: nil, maxKeys: nil, prefix: nil, requestPayer: nil, startAfter: nil)
    let response = try client.listObjectsV2(input: input).sync()
    dump(response)
  }
  
  static var allTests : [(String, (S3Tests) -> () throws -> Void)] {
    return [
      //            ("testExample", testExample),
    ]
  }
}
