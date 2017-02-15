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

func makeSafeString(_ input: String, prefix: String, pascal: Bool) -> String {
    /* todo: split camelcase INPUT into words */
    
    let invalidStr = ".:-*/ ()_"
    let wordSeps = CharacterSet(charactersIn: invalidStr)
    let words = input.components(separatedBy: wordSeps)
    
    var camel = words.map { $0.capitalized }.joined()
    if !pascal {
        camel = camel.lowercaseFirst()
    }
    
    if ReservedKeywords.contains(camel.lowercaseFirst()) {
        return "\(prefix)\(camel)"
    } else {
        return camel
    }
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
    
    let identifierRender = Filter { makeSafeString($0!, prefix: api.name, pascal: false) }
    template.register(identifierRender, forKey: "identifier")
    
    let typeRender = Filter { makeSafeString($0!, prefix: api.name, pascal: true) }
    template.register(typeRender, forKey: "type")
    
    let rendered = try! template.render(api)
    try! rendered.write(to: swiftUrl, atomically: true, encoding: .utf8)
}

doAllServices()
