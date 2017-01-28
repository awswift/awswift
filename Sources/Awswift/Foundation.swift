import Foundation

extension Array where Element: AwswiftDeserializable {
  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> [Element] {
    switch body {
    case .json(let json):
      let arr = json as! [Any]
      return arr.map { Element.deserialize(response: response, body: .json($0)) }
    case .xml(let node):
      return node.children!.map { Element.deserialize(response: response, body: .xml($0)) }
    }
    
  }
}
extension Dictionary where Key: AwswiftDeserializable {
  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> [Key: Value] {
    switch body {
    case .json(let json):
      let dict = json as! [Key: Value]
      return Dictionary(dict.map { (key: Key.deserialize(response: response, body: .json($0)), value: $1) })
    case .xml(let node):
      fatalError()
    }
    
  }
}
extension String: AwswiftDeserializable {
  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> String {
    switch body {
    case .json(let json): return json as! String
    case .xml(let node): return node.stringValue!
    }
  }
}
extension Int: AwswiftDeserializable {
  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Int {
    switch body {
    case .json(let json): return json as! Int
    case .xml(let node): return Int(node.stringValue!)!
    }
  }
}

extension Float: AwswiftDeserializable {
  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Float {
    switch body {
    case .json(let json): return json as! Float
    case .xml(let node): return Float(node.stringValue!)!
    }
  }
}
extension Double: AwswiftDeserializable {
  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Double {
    switch body {
    case .json(let json): return json as! Double
    case .xml(let node): return Double(node.stringValue!)!
    }
  }
}
extension Bool: AwswiftDeserializable {
  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Bool {
    switch body {
    case .json(let json): return json as! Bool
    case .xml(let node): return node.stringValue! == "true"
    }
  }
}
extension Date: AwswiftDeserializable {
  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Date {
    // TODO: check service date format
    switch body {
    case .json(let json): fatalError()
    case .xml(let node):
      let formatter = DateFormatter()
      formatter.timeZone = TimeZone(secondsFromGMT: 0)
      formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
      return formatter.date(from: node.stringValue!)!
    }
  }
}
extension Data: AwswiftDeserializable {
  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Data {
    switch body {
    case .json(let json): return (json as! String).data(using: .utf8)!
    case .xml(let node): fatalError()
    }
  }
}
