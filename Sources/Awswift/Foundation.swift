import Foundation

extension Array where Element: AwswiftDeserializable {
  static func deserialize(response: HTTPURLResponse, body: Any?) -> [Element] {
    let arr = body as! [Any]
      return arr.map { Element.deserialize(response: response, body: $0) }
    
  }
}

extension Array where Element: RestJsonSerializable {
    func restJsonSerialize() -> Any? {
        return map { $0.restJsonSerialize() }
    }
}

extension Dictionary where Key: AwswiftDeserializable {
  static func deserialize(response: HTTPURLResponse, body: Any?) -> [Key: Value] {
    let dict = body as! [Key: Value]
      return Dictionary(dict.map { (key: Key.deserialize(response: response, body: $0), value: $1) })
    
  }
}

//extension Optional: RestJsonSerializable {
//    func restJsonSerialize() -> Any? {
//        return nil
//    }
//}

extension String: RestJsonSerializable, AwswiftDeserializable {
  static func deserialize(response: HTTPURLResponse, body: Any?) -> String {
    return body as! String
  }
    
    func restJsonSerialize() -> Any? {
        return self
    }
}
extension Int: RestJsonSerializable, AwswiftDeserializable {
  static func deserialize(response: HTTPURLResponse, body: Any?) -> Int {
    return body as! Int
  }
    
    func restJsonSerialize() -> Any? {
        return self
    }
}

extension Float: RestJsonSerializable, AwswiftDeserializable {
  static func deserialize(response: HTTPURLResponse, body: Any?) -> Float {
    return body as! Float
  }
    
    func restJsonSerialize() -> Any? {
        return self
    }
}
extension Double: RestJsonSerializable, AwswiftDeserializable {
  static func deserialize(response: HTTPURLResponse, body: Any?) -> Double {
    return body as! Double
  }
    
    func restJsonSerialize() -> Any? {
        return self
    }
}
extension Bool: RestJsonSerializable, AwswiftDeserializable {
  static func deserialize(response: HTTPURLResponse, body: Any?) -> Bool {
    return body as! Bool
  }
    
    func restJsonSerialize() -> Any? {
        return self
    }
}
extension Date: RestJsonSerializable, AwswiftDeserializable {
  static func deserialize(response: HTTPURLResponse, body: Any?) -> Date {
    // TODO: check service date format
    fatalError()
  }
    
    func restJsonSerialize() -> Any? {
        return self
    }
}
extension Data: RestJsonSerializable, AwswiftDeserializable {
  static func deserialize(response: HTTPURLResponse, body: Any?) -> Data {
    return (body as! String).data(using: .utf8)!
  }
    
    func restJsonSerialize() -> Any? {
        return self
    }
}
