import Foundation
import Jay
import Mustache

let ReservedKeywords = ["error", "protocol", "type", "return", "public", "body", "static", "dynamic", "true", "false", "private"]

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
    let apiProtocol: ApiProtocol
    var operations: [Operation]
    
    init(name: String, LUT: [String : Shape], docs: Docs, apiProtocol: ApiProtocol) {
        self.name = name
        self.LUT = LUT
        self.docs = docs
        self.apiProtocol = apiProtocol
        self.operations = []
    }
}

class Member: MustacheBoxable {
    enum Location: String, MustacheBoxable {
        case body
        case header
        case headers
        case statusCode
        case uri
        case querystring
        
        var mustacheBox: MustacheBox {
            return Box(rawValue)
        }
    }
    
    var mustacheBox: MustacheBox {
        return Box([
            "name": name,
            "required": required,
            "shape": shape,
            "location": location,
            "locationName": locationName
            ])
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

protocol Shape: MustacheBoxable {
    var name: String { get }
    var context: ApiContext { get }
    func memberType() -> String
    
    static func fromJSON(name: String, json: JSON, context: ApiContext) -> Self
}

final class Primitive: Shape {
    let name: String
    let context: ApiContext
    let memberTypeStr: String
    
    
    var mustacheBox: MustacheBox {
        return Box([
            "name": name,
            "context": context,
            "memberType": memberTypeStr
            ])
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
    
    
    var mustacheBox: MustacheBox {
        return Box([
            "name": name,
            "context": context,
            "memberShape": memberShape,
            "memberType": memberType()
            ])
    }
    
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
}

final class AwsEnum: Shape {
    let name: String
    let context: ApiContext
    let cases: [String]
    
    
    var mustacheBox: MustacheBox {
        return Box([
            "name": name,
            "context": context,
            "cases": cases,
            "memberType": memberType()
            ])
    }
    
    func enumize(_ value: String) -> String {
        // TODO: really should camelCase words
        let invalid = Set(".:-*/ ()".characters)
        let filtered = value.characters.filter { !invalid.contains($0) }
        return String(filtered).lowercaseFirst()
    }
    
    func memberType() -> String {
        let n = name
        if ReservedKeywords.contains(n.lowercased()) {
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
    
    var mustacheBox: MustacheBox {
        let isResponse = context.operations.contains { $0.output?.name == name }
        let isRequest = context.operations.contains { $0.input?.name == name }
        let bodyMembers = members.filter { $0.location == .body }
        let headerMembers = members.filter { $0.location == .header }
        let statusCodeMembers = members.filter { $0.location == .statusCode }
        
        return Box([
            "name": name,
            "context": context,
            "members": members,
            "memberType": memberType(),
            "isResponse": isResponse,
            "isRequest": isRequest,
            "bodyMembers": bodyMembers,
            "headerMembers": headerMembers,
            "statusCodeMembers": statusCodeMembers
            ])
    }
    
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
}

final class Map: Shape {
    let name: String
    let context: ApiContext
    let key: Shape
    let value: Shape
    
    
    var mustacheBox: MustacheBox {
        return Box([
            "name": name,
            "context": context,
            "key": key,
            "value": value,
            
            "memberType": memberType()
            ])
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

class Operation: MustacheBoxable {
    let name: String
    let method: String
    let uri: String
    let respCode: Int?
    let input: Shape?
    let output: Shape?
    let errors: [Shape]
    let docs: Docs
    
    var mustacheBox: MustacheBox {
        let voidOut = Primitive(name: "AwsApiVoidOutput", memberTypeStr: "AwsApiVoidOutput", context: ApiContext(name: "", LUT: [:], docs: docs, apiProtocol: RestJson()))
        let voidIn = Primitive(name: "AwsApiVoidInput", memberTypeStr: "AwsApiVoidInput", context: ApiContext(name: "", LUT: [:], docs: docs, apiProtocol: RestJson()))
        
        return Box([
            "name": name,
            "method": method,
            "uri": uri,
            "respCode": respCode ?? "nil",
            "input": input ?? voidIn,
            "output": output ?? voidOut,
            "errors": errors
            ] as [String: Any])
    }
    
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
}

protocol ApiProtocol {}
struct RestJson: ApiProtocol {}
struct RestXml: ApiProtocol {}
struct Ec2: ApiProtocol {}
struct Query: ApiProtocol {}
struct Json: ApiProtocol {}

struct API: MustacheBoxable {
    //  enum ApiProtocol {
    //    case restJson
    //    case restXml
    //    case ec2
    //    case query
    //    case json
    //  }
    
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
    let shapes: [Shape]
    let operations: [Operation]
    let version: String
    let endpoint: EndpointType
    let apiProtocol: ApiProtocol
    let signatureVersion: SignatureVersion
    let docs: Docs
    
    var mustacheBox: MustacheBox {
        let structures = shapes.filter { $0 is Structure }
        let enums = shapes.filter { $0 is AwsEnum }
        let awsDomain: String
        
        
        switch endpoint { // TODO: support china
        case .global(let name): awsDomain = "\(name).amazonaws.com"
        case .regional(let prefix): awsDomain = "\(prefix).\\(region).amazonaws.com"
        case .s3: awsDomain = "s3-\\(region).amazonaws.com"
        }
        
        return Box([
            "name": name,
            "shapes": shapes,
            "operations": operations,
            "version": version,
            "awsDomain": awsDomain,
            "apiProtocol": apiProtocol,
            "signatureVersion": signatureVersion,
            
            "structures": structures,
            "enums": enums
            ])
    }
    
    static func fromJSON(json: JSON, docs: Docs) -> API {
        guard let json = json.dictionary else { fatalError() }
        
        let metadata = json["metadata"]!.dictionary!
        
        let version = metadata["apiVersion"]!.string!
        let name = metadata["endpointPrefix"]!.string!
        
        let apiProtocol: ApiProtocol
        switch metadata["protocol"]!.string! {
        case "rest-json": apiProtocol = RestJson()
        case "rest-xml": apiProtocol = RestXml()
        case "ec2": apiProtocol = Ec2()
        case "query": apiProtocol = Query()
        case "json": apiProtocol = Json()
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
        var shapes: [Shape] = []
        for name in sortedNames {
            let shapeJson = shapesJson.dictionary![name]!
            let shape = shapeFromJSON(name: name, json: shapeJson, context: context)
            context.LUT[name] = shape
            shapes.append(shape)
        }
        
        shapes.sort { $0.name < $1.name }
        
        let operations: [Operation] = json["operations"]!.dictionary!.map { (key, json) in
            return Operation.fromJSON(json: json, docs: docs, LUT: context.LUT)
            }.sorted { $0.name < $1.name }
        
        context.operations = operations
        
        return API(name: name, shapes: shapes, operations: operations, version: version, endpoint: endpoint, apiProtocol: apiProtocol, signatureVersion: signatureVersion, docs: docs)
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
    
    init(name: String, shapes: [Shape], operations: [Operation], version: String, endpoint: EndpointType, apiProtocol: ApiProtocol, signatureVersion: SignatureVersion, docs: Docs) {
        self.name = name
        self.shapes = shapes
        self.operations = operations
        self.version = version
        self.endpoint = endpoint
        self.apiProtocol = apiProtocol
        self.signatureVersion = signatureVersion
        self.docs = docs
    }
}
