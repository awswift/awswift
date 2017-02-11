import XCTest
@testable import Awswift
import Signer

class S3Tests: XCTestCase {
    func testLambda() {
        AwsCredentials.sharedCredentials = AwsCredentials(
            accessKeyId: "AKIAJWMRCSBBKQO4HQCQ",
            secretAccessKey: "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",
            sessionToken: nil
        )
        
        let client = lambda.Client(region: "ap-southeast-2")
        
        let exp = expectation(description: "moo")
        
        let input = lambda.ListFunctionsRequest(marker: nil, maxItems: nil)
        let task = client.ListFunctions(input: input) { (resp, error) in
            if let resp = resp {
                dump(resp)
                exp.fulfill()
            } else {
                XCTFail()
            }
        }
        
        task.resume()
        
        waitForExpectations(timeout: 5) { (error) in
            if let error = error {
                XCTFail()
            }
        }
    }
//  func testS3() throws {
//    
//    let client = S3.Client(region: "us-east-1")
//    let input = S3.ListObjectsV2Request(bucket: "iconicalpp.com", continuationToken: nil, delimiter: nil, encodingType: nil, fetchOwner: nil, maxKeys: nil, prefix: nil, requestPayer: nil, startAfter: nil)
//    let response = try client.listObjectsV2(input: input).sync()
//    dump(response)
//  }
  
  static var allTests : [(String, (S3Tests) -> () throws -> Void)] {
    return [
      //            ("testExample", testExample),
    ]
  }
}
