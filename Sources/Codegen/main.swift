import Foundation
import SwiftyJSON
import Commander

func generateSwift(apiUrl: URL, docsUrl: URL, swiftUrl: URL) {
  let apiData = try! Data(contentsOf: apiUrl)
  let apiJson = JSON(data: apiData)
  
  let docsData = try! Data(contentsOf: docsUrl)
  let docsJson = JSON(data: docsData)
  let docs = Docs.fromJSON(docs: docsJson)

  let api = API.fromJSON(json: apiJson, docs: docs)
  let str = api.emit()
  
  try! str.write(to: swiftUrl, atomically: true, encoding: .utf8)
}

func doAllServices() {
  let thisUrl = URL(fileURLWithPath: #file)
  let apiDefRootUrl = URL(string: "../../APIDefinitions", relativeTo: thisUrl)!
  
  let allApiDefUrls = try! FileManager.default.contentsOfDirectory(at: apiDefRootUrl, includingPropertiesForKeys: [], options: [])
#if true
  let interestingSubset = ["s3", "ec2", "lambda", "sqs", "ecr"]
  let interestingApiDefs = allApiDefUrls.filter { interestingSubset.contains($0.pathComponents[$0.pathComponents.endIndex - 1]) }
#else
  let interestingApiDefs = allApiDefs
#endif
  
  for apiDefUrl in interestingApiDefs {
    let name = apiDefUrl.lastPathComponent
    let swiftUrl = URL(string: "../Awswift/\(name).swift", relativeTo: thisUrl)!
    let apiUrl = apiDefUrl.appendingPathComponent("api-2.json")
    let docsUrl = apiDefUrl.appendingPathComponent("docs-2.json")
    generateSwift(apiUrl: apiUrl, docsUrl: docsUrl, swiftUrl: swiftUrl)
  }
  
  print(interestingApiDefs)
}

doAllServices()
