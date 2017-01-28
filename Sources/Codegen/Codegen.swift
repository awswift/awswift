import Foundation
import Jay

let ReservedKeywords = ["Error", "Protocol", "Type", "Return", "Public", "Body"]

struct Docs {
  let operations: [String: String]
  let shapes: [String: String]
  let members: [String: String]
  
  static func fromJSON(docs: JSON) -> Docs {
    guard let docs = docs.dictionary else { fatalError() }
    
    let operationsAry: [(key: String, value: String)] = docs["operations"]!.dictionary!.map { (name, html) in
      let markdown = htmlToMarkdown(html.string!)
      return (name, markdown)
    }
    
    let shapesAry: [(key: String, value: String)] = docs["shapes"]!.dictionary!.flatMap { (name, shape) in
      let markdown = shape.dictionary!["base"]?.string
      return markdown.flatMap { (name, $0) }
    }
    
    let shapes = docs["shapes"]!.dictionary!
    let refs = shapes.map { key, val in val.dictionary!["refs"]!.dictionary! }
    let members = refs.flatMap { refList in refList.map { (key: $0, value: $1.string ?? "") } }
    
    return Docs(operations: Dictionary(operationsAry), members: Dictionary(members), shapes: Dictionary(shapesAry))
  }
  
  func docsForField(shape: String, member: String) -> String? {
    return members["\(shape)$\(member)"]
  }
  
  init(operations: [String: String], members: [String: String], shapes: [String: String]) {
    self.operations = operations
    self.shapes = shapes
    self.members = members
  }
  
  static func htmlToMarkdown(_ html: String) -> String {
    return html
    
    #if os(Linux)
      let buildProcess = Task()
    #else
      let buildProcess = Process()
    #endif
    buildProcess.launchPath = "/bin/bash"
    buildProcess.arguments = ["-c", "upmark"]
    buildProcess.environment = ProcessInfo.processInfo.environment
    
    var outStr = ""
    let out = Pipe()
    
    buildProcess.standardOutput = out
    out.fileHandleForReading.readabilityHandler = { handle in
      let str = String(data: handle.availableData, encoding: .utf8)!
      outStr.append(str)
    }
    
    let inPipe = Pipe()
    buildProcess.standardInput = inPipe
    
    buildProcess.terminationHandler = { task in
      out.fileHandleForReading.readabilityHandler = nil
    }
    
    buildProcess.launch()
    inPipe.fileHandleForWriting.write(html.data(using: .utf8)!)
    inPipe.fileHandleForWriting.closeFile()
    buildProcess.waitUntilExit()
    
    return outStr
  }
  
}

class ApiContext {
  let name: String
  var LUT: [String: Shape]
  let docs: Docs
  let apiProtocol: API.ApiProtocol
  
  init(name: String, LUT: [String : Shape], docs: Docs, apiProtocol: API.ApiProtocol) {
    self.name = name
    self.LUT = LUT
    self.docs = docs
    self.apiProtocol = apiProtocol
  }
}

class Member {
  enum Location: String {
    case body
    case header
    case headers
    case statusCode
    case uri
    case querystring
  }
  
  let name: String
  let required: Bool
  var shape: Shape
  let location: Location
  let locationName: String
  
  static func fromJSON(name: String, required: Bool, json: JSON, context: ApiContext) -> Member {
    guard let json = json.dictionary else { fatalError() }
    
    let shapeName = json["shape"]!.string!
    let location = Location(rawValue: json["location"]?.string ?? "body")!
    
    return Member(
      name: name,
      required: required,
      shape: context.LUT[shapeName]!,
      location: location,
      locationName: json["locationName"]?.string ?? name
    )
  }
  
  init(name: String, required: Bool, shape: Shape, location: Location, locationName: String) {
    self.name = name
    self.required = required
    self.shape = shape
    self.location = location
    self.locationName = locationName
  }
  
  func memberName() -> String {
    if ReservedKeywords.contains(name) {
      return "\(shape.context.name.lowercaseFirst())\(name)"
    } else {
      return name.lowercaseFirst()
    }
  }
  
  func optionalityIndicator() -> String {
    return required ? "" : "?"
  }
  
  func deserialization() -> String {
    switch location {
    case .statusCode: return "      \(memberName()): response.statusCode"
    case .header: return "      \(memberName()): response.allHeaderFields[\"\(locationName)\"].flatMap { ($0 is NSNull) ? nil : \(shape.memberType()).deserialize(response: response, body: .json($0)) }\(required ? "!" : "")"
    case .body:
      switch shape.context.apiProtocol {
      case .restJson:
        return "      \(memberName()): jsonDict[\"\(locationName)\"].flatMap { ($0 is NSNull) ? nil : \(shape.memberType()).deserialize(response: response, body: .json($0)) }\(required ? "!" : "")"
      case .restXml:
        if let list = shape as? List {
          return "      \(memberName()): try! node.nodes(forXPath: \"\(locationName)\").map { \(list.memberShape.memberType()).deserialize(response: response, body: .xml($0)) }"
        } else {
          return "      \(memberName()): try! node.nodes(forXPath: \"\(locationName)\").first.map { \(shape.memberType()).deserialize(response: response, body: .xml($0)) }\(required ? "!" : "")"
        }
        
      default: fatalError()
      }
    case .headers: return "      \(memberName()): Dictionary(response.allHeaderFields.map { (key: $0 as! String, value: $1 as! String) }.filter { $0.key.lowercased().hasPrefix(\"\(locationName)\") })"
    default: fatalError()
    }
  }
  
  func declaration() -> String {
    return "\(memberName()): \(shape.memberType())\(optionalityIndicator())"
  }
}

enum ShapeType {
  case string // enum as well?
  case `enum`
  case structure(Structure)
  case integer
  case long
  case boolean
  case blob
  case list
  case timestamp
  case unknown
}

protocol Shape {
  var name: String { get }
  var context: ApiContext { get }
  func emit() -> String
  func memberType() -> String
  
  static func fromJSON(name: String, json: JSON, context: ApiContext) -> Self
}

final class Primitive: Shape {
  let name: String
  let context: ApiContext
  let memberTypeStr: String
  
  func emit() -> String {
    return ""
  }
  
  func memberType() -> String {
    return memberTypeStr
  }
  
  static func fromJSON(name: String, json: JSON, context: ApiContext) -> Primitive {
    guard let json = json.dictionary else { fatalError() }
    
    switch json["type"]!.string! {
    case "string":    return Primitive(name: name, memberTypeStr: "String", context: context)
    case "integer":   return Primitive(name: name, memberTypeStr: "Int", context: context)
    case "long":      return Primitive(name: name, memberTypeStr: "Int", context: context)
    case "blob":      return Primitive(name: name, memberTypeStr: "Data", context: context)
    case "boolean":   return Primitive(name: name, memberTypeStr: "Bool", context: context)
    case "timestamp": return Primitive(name: name, memberTypeStr: "Date", context: context)
    case "double":    return Primitive(name: name, memberTypeStr: "Double", context: context)
    case "float":     return Primitive(name: name, memberTypeStr: "Float", context: context)
    default: fatalError()
    }
    //return Primitive(shapeType: shapeType)
  }
  
  init(name: String, memberTypeStr: String, context: ApiContext) {
    self.name = name
    self.memberTypeStr = memberTypeStr
    self.context = context
  }
}

final class List: Shape {
  let name: String
  let context: ApiContext
  let memberShape: Shape
  
  static func fromJSON(name: String, json: JSON, context: ApiContext) -> List {
    guard let json = json.dictionary else { fatalError() }
    
    let shapeName = json["member"]!.dictionary!["shape"]!.string!
    let memberShape = context.LUT[shapeName]!
    
    return List(
      name: name,
      memberShape: memberShape,
      context: context
    )
  }
  
  init(name: String, memberShape: Shape, context: ApiContext) {
    self.name = name
    self.memberShape = memberShape
    self.context = context
  }
  
  func memberType() -> String {
    return "[\(memberShape.memberType())]"
  }
  
  func emit() -> String {
    return ""
  }
}

final class AwsEnum: Shape {
  let name: String
  let context: ApiContext
  let cases: [String]
  
  func emit() -> String {
    var str = ""
    let e = { line in str = str + line + "\n" }
    
    e("enum \(memberType()): String, AwswiftDeserializable, AwswiftSerializable {")
    cases.forEach { e("  case `\(enumize($0))` = \"\($0)\"") }
    
    e("")
    e("  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> \(memberType()) {")
    e("    switch body { ")
    e("    case .json(let json): return \(memberType())(rawValue: json as! String)!")
    e("    case .xml(let node): return \(memberType())(rawValue: node.stringValue!)!")
    e("    }")
    e("  }")
    e("")
    e("  func serialize() -> SerializedForm {")
    e("    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))")
    e("  }")
    
    e("}")
    
    return str
  }
  
  func enumize(_ value: String) -> String {
    // TODO: really should camelCase words
    let invalid = Set(".:-*/ ()".characters)
    let filtered = value.characters.filter { !invalid.contains($0) }
    return String(filtered).lowercaseFirst()
  }
  
  func memberType() -> String {
    let n = name.capitalized
    if ReservedKeywords.contains(n) {
      return "\(context.name.capitalized)\(n)"
    } else {
      return n
    }
  }
  
  static func fromJSON(name: String, json: JSON, context: ApiContext) -> AwsEnum {
    guard let json = json.dictionary else { fatalError() }
    
    let cases = json["enum"]!.array!.map { $0.string! }
    return AwsEnum(name: name, cases: cases, context: context)
  }
  
  init(name: String, cases: [String], context: ApiContext) {
    self.name = name
    self.cases = cases
    self.context = context
  }
}

final class Structure: Shape {
  let name: String
  let context: ApiContext
  let members: [Member]
  
  static func fromJSON(name: String, json: JSON, context: ApiContext) -> Structure {
    guard let json = json.dictionary else { fatalError() }
    
    let required = json["required"]?.array?.flatMap { $0.string } ?? []
    let members = json["members"]!.dictionary!.map { Member.fromJSON(name: $0, required: required.contains($0), json: $1, context: context) }.sorted { $0.name < $1.name }
    
    return Structure(
      name: name,
      members: members,
      context: context
    )
  }
  
  init(name: String, members: [Member], context: ApiContext) {
    self.name = name
    self.members = members
    self.context = context
  }
  
  func memberType() -> String {
    if ReservedKeywords.contains(name) {
      return "\(context.name.capitalized)\(name)"
    } else {
      return name
    }
  }
  
  func emitSerializeMethod() -> [String] {
    if name.hasSuffix("Response") || name.hasSuffix("Exception") || name.hasSuffix("Output") {
      return []
    }
    
    let grouped = members.categorise { $0.location }
    
    let toLine: (String, Member) -> (String) = { l, m in
      if m.required {
        return "  \(l)[\"\(m.locationName)\"] = \"\\(\(m.memberName()))\""
      } else {
        return "  if \(m.memberName()) != nil { \(l)[\"\(m.locationName)\"] = \"\\(\(m.memberName())!)\" }"
      }
    }
    
    let uriLines = grouped[.uri]?.map { toLine("uri", $0) } ?? []
    let qsLines = grouped[.querystring]?.map { toLine("querystring", $0) } ?? []
    let headerLines = grouped[.header]?.map { toLine("header", $0) } ?? []
    
    let bodyLines: [String] = grouped[.body]?.map { m in
      if m.required {
        return "  body[\"\(m.locationName)\"] = \(m.memberName())"
      } else {
        return "  if \(m.memberName()) != nil { body[\"\(m.locationName)\"] = \(m.memberName())! }"
      }
      } ?? []
    
    let firstLines = [
      "func serialize() -> SerializedForm {",
      "  \(uriLines.count    == 0 ? "let" : "var") uri: [String: String] = [:]",
      "  \(qsLines.count     == 0 ? "let" : "var") querystring: [String: String] = [:]",
      "  \(headerLines.count == 0 ? "let" : "var") header: [String: String] = [:]",
      "  \(bodyLines.count   == 0 ? "" : "var body: [String: Any] = [:]")",
      ""
    ]
    
    let body = bodyLines.count == 0 ? ".empty" : ".json(body)"
    
    let lastLines = [
      "",
      "  return SerializedForm(uri: uri, queryString: querystring, header: header, body: \(body))",
      "}"
    ]
    
    // TODO lame code because swift compiler inference is SLOW at adding together arrays
    return [firstLines, uriLines, qsLines, headerLines, bodyLines, lastLines].flatMap { $0 }
  }
  
  func emitDeserializeMethod() -> [String] {
    if name.hasSuffix("Request") && name != "CancelledSpotInstanceRequest" && name != "SpotInstanceRequest" {
      return []
    }
    
    
    let fieldInitLines = members.map { $0.deserialization() }
    let fieldLines = fieldInitLines.joined(separator: ",\n")
    let dictLine: String
    let bodyLine: String
    
    if members.filter({ $0.location == .body }).count == 0 {
      dictLine = ""
        bodyLine = "  fatalError()"
    } else {
      switch context.apiProtocol {
      case .restJson:
        dictLine = "  guard case let .json(json) = body else { fatalError() }\n  let jsonDict = json as! [String: Any]"
        bodyLine = "  let json = try! JSONSerialization.jsonObject(with: data, options: [])\n  return .json(json)"
      case .restXml:
        dictLine = "  guard case let .xml(node) = body else { fatalError() }"
        bodyLine = "  let node = try! XMLDocument(data: data, options: 0).child(at: 0)!\n  return .xml(node)"
      default: fatalError()
      }
    }
    
    
    return [
        "static func deserializableBody(data: Data) -> DeserializableBody {",
        bodyLine,
        "}\n",
      "static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> \(memberType()) {",
      dictLine,
      "  return \(memberType())(",
      fieldLines,
      "  )",
      "}"
    ]
  }
  
  func emit() -> String {
    var str = ""
    let e = { line in str = str + line + "\n" }
    
    let protocols: String
    if name == "CancelledSpotInstanceRequest" || name == "SpotInstanceRequest" {
      protocols = "AwswiftSerializable, AwswiftDeserializable"
    } else if name.hasSuffix("Request") {
      protocols = "AwswiftSerializable"
    } else if name.hasSuffix("Response") || name.hasSuffix("Output") {
      protocols = "AwswiftDeserializable"
    } else if name.hasSuffix("Exception") {
      protocols = "Error, AwswiftDeserializable"
    } else {
      protocols = "AwswiftSerializable, AwswiftDeserializable"
    }
    
    e("public struct \(memberType()): \(protocols) {")
    
    members.forEach { m in
      if let doc = context.docs.docsForField(shape: name, member: m.name) {
        e("/**")
        e(doc)
        e(" */")
      }
      e("  public let \(m.declaration())")
    }
    
    e("")
    emitSerializeMethod().forEach { e("  \($0)") }
    e("")
    emitDeserializeMethod().forEach { e("  \($0)") }
    e("")
    
    e("/**")
    e("    - parameters:")
    members.forEach { e("      - \($0.memberName()): \(context.docs.docsForField(shape: name, member: $0.name)!)") }
    e(" */")
    let decls = members.map { $0.declaration() }.joined(separator: ", ")
    e("  public init(\(decls)) {")
    members.forEach { e("self.\($0.memberName()) = \($0.memberName())") }
    e("  }")
    
    e("}")
    
    return str
  }
}

final class Map: Shape {
  let name: String
  let context: ApiContext
  let key: Shape
  let value: Shape
  
  func emit() -> String {
    return ""
  }
  
  func memberType() -> String {
    return "[\(key.memberType()): \(value.memberType())]"
  }
  
  static func fromJSON(name: String, json: JSON, context: ApiContext) -> Map {
    guard let json = json.dictionary else { fatalError() }
    
    let keyName = json["key"]!.dictionary!["shape"]!.string!
    let valueName = json["value"]!.dictionary!["shape"]!.string!
    return Map(name: name, key: context.LUT[keyName]!, value: context.LUT[valueName]!, context: context)
  }
  
  init(name: String, key: Shape, value: Shape, context: ApiContext) {
    self.name = name
    self.context = context
    self.key = key
    self.value = value
  }
}

class Operation {
  let name: String
  let method: String
  let uri: String
  let respCode: Int?
  let input: Shape?
  let output: Shape?
  let errors: [Shape]
  let docs: Docs
  
  static func fromJSON(json: JSON, docs: Docs, LUT: [String: Shape]) -> Operation {
    guard let json = json.dictionary else { fatalError() }
    
    let name = json["name"]!.string!
    let http = json["http"]!.dictionary!
    let method = http["method"]!.string!
    let uri = http["requestUri"]!.string!
    let respCode = http["responseCode"]?.uint.flatMap { Int($0) }
    
    let inputName = json["input"]?.dictionary?["shape"]?.string
    let outputName = json["output"]?.dictionary?["shape"]?.string
    
    let errorJsons = json["errors"]?.array ?? []
    let errorNames = errorJsons.map { $0.dictionary!["shape"]!.string! }
    
    let input = inputName.map { LUT[$0]! }
    let output = outputName.map { LUT[$0]! }
    let errors = errorNames.map { LUT[$0]! }.sorted { $0.name < $1.name }
    
    return Operation(
      name: name,
      method: method,
      uri: uri,
      respCode: respCode,
      input: input,
      output: output,
      errors: errors,
      docs: docs
    )
  }
  
  init(name: String, method: String, uri: String, respCode: Int?, input: Shape?, output: Shape?, errors: [Shape], docs: Docs) {
    self.name = name
    self.method = method
    self.uri = uri
    self.respCode = respCode
    self.input = input
    self.output = output
    self.errors = errors
    self.docs = docs
  }
  
  func emit(api: API) -> String {
    var str = ""
    let e = { line in str = str + line + "\n" }
    
    let outputType = output?.memberType() ?? "AwsApiVoidOutput"
    let inputType = input?.memberType() ?? "AwsApiVoidInput"
    
    if let doc = docs.operations[name] {
      e("/**")
      e(doc)
      e(" */")
    }
    
    let hostname: String
    switch api.endpoint {
    case .regional(let prefix): hostname = "\(prefix).\\(self.region).amazonaws.com"
    case .global(let endpoint): hostname = endpoint
    case .s3: hostname = "s3.dualstack.\\(self.region).amazonaws.com"
    }
    
    e("func \(name.lowercaseFirst())(input: \(inputType)) -> ApiCallTask<\(outputType)> {")
    e("  return ApiCallTask { cb in")
    e("    let task = awsApiCallTask(")
    e("      session: self.session,")
    e("      credentials: self.credentialsProvider.provideAwsCredentials()!,")
    e("      scope: self.scope(),")
    e("      queue: self.queue,")
    e("      urlString: \"https://\(hostname)\(uri)\", ")
    e("      httpMethod: \"\(method)\", ")
    e("      expectedStatus: \(respCode == nil ? "nil" : "\(respCode!)"), ")
    e("      input: input, ")
    e("      completionHandler: cb")
    e("    )")
    e("    task.resume()")
    e("  }")
    e("}")
    e("")
    
    return str
  }
}

struct API {
  enum ApiProtocol {
    case restJson
    case restXml
    case ec2
    case query
    case json
  }
  
  enum SignatureVersion {
    case v4
    case v2
    case s3
  }
  
  enum EndpointType {
    case regional(prefix: String)
    case global(endpoint: String)
    case s3
  }
  
  let name: String
  let shapes: [String: Shape]
  let operations: [Operation]
  let version: String
  let endpoint: EndpointType
  let apiProtocol: ApiProtocol
  let signatureVersion: SignatureVersion
  let docs: Docs
  
  static func fromJSON(json: JSON, docs: Docs) -> API {
    guard let json = json.dictionary else { fatalError() }
    
    let metadata = json["metadata"]!.dictionary!
    
    let version = metadata["apiVersion"]!.string!
    let name = metadata["endpointPrefix"]!.string!
    
    let apiProtocol: ApiProtocol
    switch metadata["protocol"]!.string! {
    case "rest-json": apiProtocol = .restJson
    case "rest-xml": apiProtocol = .restXml
    case "ec2": apiProtocol = .ec2
    case "query": apiProtocol = .query
    case "json": apiProtocol = .json
    default: fatalError()
    }
    
    let signatureVersion: SignatureVersion
    switch metadata["signatureVersion"]!.string! {
    case "v2": signatureVersion = .v2
    case "v4": signatureVersion = .v4
    case "s3": signatureVersion = .s3
    default: fatalError()
    }
    
    let endpoint: EndpointType
    if name == "s3" {
      endpoint = .s3
    } else if let global = metadata["globalEndpoint"]?.string {
      endpoint = .global(endpoint: global)
    } else {
      endpoint = .regional(prefix: name)
    }
    
    let context = ApiContext(name: name, LUT: [:], docs: docs, apiProtocol: apiProtocol)
    
    let shapesJson = json["shapes"]!
    let sortedNames = sortedShapeNames(unsorted: shapesJson)
    for name in sortedNames {
      let shapeJson = shapesJson.dictionary![name]!
      context.LUT[name] = shapeFromJSON(name: name, json: shapeJson, context: context)
    }
    
    let operations: [Operation] = json["operations"]!.dictionary!.map { (key, json) in
      return Operation.fromJSON(json: json, docs: docs, LUT: context.LUT)
    }.sorted { $0.name < $1.name }
    
    return API(name: name, shapes: context.LUT, operations: operations, version: version, endpoint: endpoint, apiProtocol: apiProtocol, signatureVersion: signatureVersion, docs: docs)
  }
  
  static func sortedShapeNames(unsorted: JSON) -> [String] {
    guard let unsorted = unsorted.dictionary else { fatalError() }
    
    let deps = NSMutableDictionary()
    
    for (name, shape) in unsorted {
      guard let shape = shape.dictionary else { fatalError() }
    
      var memberShapes: [String] = []
      if let members = shape["members"]?.dictionary {
        memberShapes.append(contentsOf: members.map { $1.dictionary!["shape"]!.string! })
      }
    
      shape["member"]?.dictionary?["shape"]?.string.map { memberShapes.append($0) }
      shape["key"]?.dictionary?["shape"]?.string.map { memberShapes.append($0) }
      shape["value"]?.dictionary?["shape"]?.string.map { memberShapes.append($0) }
      deps[name] = memberShapes
    }
    
    // TODO: come back to this with swiftyjson
    let jsonHack = try! JSONSerialization.data(withJSONObject: deps, options: [])
    let unjsonHack = try! JSONSerialization.jsonObject(with: jsonHack, options: []) as! [String: [String]]
    let sorted = try! topo_sort(dependency_list: unjsonHack)
    return sorted
  }
  
  static func shapeFromJSON(name: String, json: JSON, context: ApiContext) -> Shape {
    switch json.dictionary!["type"]!.string! {
    case "structure": return Structure.fromJSON(name: name, json: json, context: context)
    case "list": return List.fromJSON(name: name, json: json, context: context)
    case "string" where json.dictionary!["enum"] != nil: return AwsEnum.fromJSON(name: name, json: json, context: context)
    case "map": return Map.fromJSON(name: name, json: json, context: context)
    default: return Primitive.fromJSON(name: name, json: json, context: context)
    }
  }
  
  init(name: String, shapes: [String: Shape], operations: [Operation], version: String, endpoint: EndpointType, apiProtocol: ApiProtocol, signatureVersion: SignatureVersion, docs: Docs) {
    self.name = name
    self.shapes = shapes
    self.operations = operations
    self.version = version
    self.endpoint = endpoint
    self.apiProtocol = apiProtocol
    self.signatureVersion = signatureVersion
    self.docs = docs
  }
  
  func emit() -> String {
    var str = ""
    let e = { line in str = str + line + "\n" }
    
    e("import Foundation")
    e("import Signer")
    e("struct \(name.capitalized) {")
    e("  struct Client {")
    e("    let region: String")
    e("    let credentialsProvider: AwsCredentialsProvider")
    e("    let session: URLSession")
    e("    let queue: DispatchQueue")
    e("")
    e("    init(region: String) {")
    e("      self.region = region")
    e("      self.credentialsProvider = DefaultChainProvider()")
    e("      self.session = URLSession(configuration: URLSessionConfiguration.default)")
    e("      self.queue = DispatchQueue(label: \"awswift.\(name.capitalized).Client.queue\")")
    e("    }")
    e("")
    if name == "s3" {
      e("    func scope() -> AwsCredentialsScope {")
      e("      return AwsCredentialsScope(date: Date(), region: region, service: \"s3\")")
      e("    }")
      e("")
    } else {
      e("    func scope() -> AwsCredentialsScope {")
      e("      return AwsCredentialsScope(url: URL(string: \"https://\")!)!")
      e("    }")
      e("")
    }
    
    operations.forEach { e($0.emit(api: self)) }
    e("  }")
    
    let shapeNames = shapes.keys.sorted()
    shapeNames.forEach { name in
      let shape = shapes[name]!
      if let doc = docs.shapes[name] {
        e("/**")
        e(doc)
        e(" */")
      }
      e(shape.emit())
    }

    e("}")
    
    return str
  }
}
