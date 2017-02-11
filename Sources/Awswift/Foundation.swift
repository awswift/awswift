import Foundation

extension Array where Element: AwswiftDeserializable {
  static func deserialize(response: HTTPURLResponse, body: Any?) -> [Element] {
    let arr = body as! [Any]
      return arr.map { Element.deserialize(response: response, body: $0) }
    
  }
}

extension Array where Element: RestJsonSerializable {
    func restJsonSerialize() -> RestJsonFieldValue {
        let arr = map { $0.restJsonSerialize() }
        return .array(arr)
    }
}

extension Dictionary where Key: AwswiftDeserializable {
  static func deserialize(response: HTTPURLResponse, body: Any?) -> [Key: Value] {
      let dict = body as! [Key: Value]
      return Dictionary(dict.map { (key: Key.deserialize(response: response, body: $0), value: $1) })
    
  }
}

extension Dictionary where Value: RestJsonSerializable {
    func restJsonSerialize() -> RestJsonFieldValue {
        var arr: [RestJsonField] = []
        
        for (key, val) in self {
            let field = RestJsonField(name: key as! String, location: .body, value: val.restJsonSerialize())
            arr.append(field)
        }
        
        return .object(arr)
    }
}

//extension Optional: RestJsonSerializable {
//    func restJsonSerialize() -> RestJsonFieldValue {
//        return nil
//    }
//}

extension String: RestJsonSerializable, AwswiftDeserializable {
  static func deserialize(response: HTTPURLResponse, body: Any?) -> String {
    return body as! String
  }
    
    func restJsonSerialize() -> RestJsonFieldValue {
        return .string(self)
    }
}
extension Int: RestJsonSerializable, AwswiftDeserializable {
  static func deserialize(response: HTTPURLResponse, body: Any?) -> Int {
    return body as! Int
  }
    
    func restJsonSerialize() -> RestJsonFieldValue {
        return .numberI(self)
    }
}

//extension Float: RestJsonSerializable, AwswiftDeserializable {
//  static func deserialize(response: HTTPURLResponse, body: Any?) -> Float {
//    return body as! Float
//  }
//    
//    func restJsonSerialize() -> RestJsonFieldValue {
//        return self
//    }
//}
//extension Double: RestJsonSerializable, AwswiftDeserializable {
//  static func deserialize(response: HTTPURLResponse, body: Any?) -> Double {
//    return body as! Double
//  }
//    
//    func restJsonSerialize() -> RestJsonFieldValue {
//        return self
//    }
//}
extension Bool: RestJsonSerializable, AwswiftDeserializable {
  static func deserialize(response: HTTPURLResponse, body: Any?) -> Bool {
    return body as! Bool
  }
    
    func restJsonSerialize() -> RestJsonFieldValue {
        return .bool(self)
    }
}
extension Date: RestJsonSerializable, AwswiftDeserializable {
  static func deserialize(response: HTTPURLResponse, body: Any?) -> Date {
    // TODO: check service date format
    fatalError()
  }
    
    func restJsonSerialize() -> RestJsonFieldValue {
        return .date(self)
    }
}
extension Data: RestJsonSerializable, AwswiftDeserializable {
  static func deserialize(response: HTTPURLResponse, body: Any?) -> Data {
    return (body as! String).data(using: .utf8)!
  }
    
    func restJsonSerialize() -> RestJsonFieldValue {
        return .data(self)
    }
}
