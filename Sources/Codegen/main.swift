import Foundation
import Jay
import Commander
import Mustache

func generateSwift(apiUrl: URL, docsUrl: URL, swiftUrl: URL) {
  let apiData = try! Data(contentsOf: apiUrl)
  let apiJson = try! Jay().jsonFromData([UInt8](apiData))
  
  let docsData = try! Data(contentsOf: docsUrl)
  let docsJson = try! Jay().jsonFromData([UInt8](docsData))
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
  let interestingSubset = ["cloudformation"]//, "lambda", "cloudformation"]
  let interestingApiDefs = allApiDefUrls.filter { interestingSubset.contains($0.pathComponents[$0.pathComponents.endIndex - 1]) }
#else
  let interestingApiDefs = allApiDefs
#endif
  
  for apiDefUrl in interestingApiDefs {
    let name = apiDefUrl.lastPathComponent
    let swiftUrl = URL(string: "../Awswift/\(name).swift", relativeTo: thisUrl)!
    let apiUrl = apiDefUrl.appendingPathComponent("api-2.json")
    let docsUrl = apiDefUrl.appendingPathComponent("docs-2.json")
//    generateSwift(apiUrl: apiUrl, docsUrl: docsUrl, swiftUrl: swiftUrl)
    doMustache(apiUrl: apiUrl, docsUrl: docsUrl, swiftUrl: swiftUrl)
  }
  
  print(interestingApiDefs)
}

func doMustache(apiUrl: URL, docsUrl: URL, swiftUrl: URL) {
    let apiData = try! Data(contentsOf: apiUrl)
    let apiJson = try! Jay().jsonFromData([UInt8](apiData))
    
    let docsData = try! Data(contentsOf: docsUrl)
    let docsJson = try! Jay().jsonFromData([UInt8](docsData))
    let docs = Docs.fromJSON(docs: docsJson)
    let api = API.fromJSON(json: apiJson, docs: docs)
    
    let template = try! Template(path: "/Users/aidan/dev/awswift/awswift/QueryApi.swift.mst")
    template.register(StandardLibrary.each, forKey: "each")
    
    let identifierRender = Filter { (identifier: String?) in
        guard let identifier = identifier else { return "" }
        
        let invalid = Set(".:-*/ ()".characters)
        let filtered = identifier.characters.filter { !invalid.contains($0) }
        let safe = String(filtered).lowercaseFirst()
        
        if ReservedKeywords.contains(safe) {
            return "\(api.name)\(safe)"
        } else {
            return safe
        }
    }
    template.register(identifierRender, forKey: "identifier")
    
    let rendered = try! template.render(api)
    try! rendered.write(to: swiftUrl, atomically: true, encoding: .utf8)
}

doAllServices()
