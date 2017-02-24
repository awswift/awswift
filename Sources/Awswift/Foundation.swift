import Foundation

extension Array where Element: AwswiftDeserializable {
  static func deserialize(response: HTTPURLResponse, body: Any?) -> [Element] {
    let arr: [Any]
    
    if let node = body as? XMLNode { // todo remove hack
        arr = node.children!
    } else {
        arr = body as! [Any]
    }
    
    return arr.map { Element.deserialize(response: response, body: $0) }
    
    
  }
}

extension Array where Element: RestJsonSerializable {
    func restJsonSerialize() -> RestJsonFieldValue {
        let arr = map { $0.restJsonSerialize() }
        return .array(arr)
    }
}

extension Array where Element: RestXmlSerializable {
  func restXmlSerialize() -> RestXmlFieldValue {
    let elem = XMLElement(name: "member")
    for e in self {
      elem.addChild(e.restXmlSerialize().node)
    }
//    let arr = map { $0.restXmlSerialize() }
    return RestXmlFieldValue(node: elem)
  }
}


extension Array where Element: QuerySerializable {
    func querySerialize() -> QueryFieldValue {
        let arr = map { $0.querySerialize() }
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

extension Dictionary where Value: QuerySerializable {
    func querySerialize() -> QueryFieldValue {
        var obj: [String: QueryFieldValue] = [:]
        
        for (key, val) in self {
            let qval = val.querySerialize()
            obj["\(key)"] = qval
        }
        
        return .object(obj)
    }
}

//extension Optional: RestJsonSerializable {
//    func restJsonSerialize() -> RestJsonFieldValue {
//        return nil
//    }
//}

extension String: RestJsonSerializable, AwswiftDeserializable, QuerySerializable, RestXmlSerializable {
  static func deserialize(response: HTTPURLResponse, body: Any?) -> String {
    if let node = body as? XMLNode { // todo remove hack
        return node.stringValue!
    } else {
        return body as! String
    }
  }
    
    func restXmlSerialize() -> RestXmlFieldValue {
        return RestXmlFieldValue(node: XMLNode.text(withStringValue: self) as! XMLNode)
    }
    
    func restJsonSerialize() -> RestJsonFieldValue {
        return .string(self)
    }
    
    func querySerialize() -> QueryFieldValue {
        return .string(self)
    }
}
extension Int: RestJsonSerializable, AwswiftDeserializable, QuerySerializable {
  static func deserialize(response: HTTPURLResponse, body: Any?) -> Int {
    return body as! Int
  }
    
    func restJsonSerialize() -> RestJsonFieldValue {
        return .numberI(self)
    }


  func restXmlSerialize() -> RestXmlFieldValue {
    return RestXmlFieldValue(node: XMLNode.text(withStringValue: "") as! XMLNode)
  }


    func querySerialize() -> QueryFieldValue {
        return .string("")
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
extension Bool: RestJsonSerializable, AwswiftDeserializable, QuerySerializable {
  static func deserialize(response: HTTPURLResponse, body: Any?) -> Bool {
    return body as! Bool
  }
    
    func restJsonSerialize() -> RestJsonFieldValue {
        return .bool(self)
    }
    
    func querySerialize() -> QueryFieldValue {
        return .string("\(self)")
    }

  func restXmlSerialize() -> RestXmlFieldValue {
    return RestXmlFieldValue(node: XMLNode.text(withStringValue: "") as! XMLNode)
  }
}
extension Date: RestJsonSerializable, AwswiftDeserializable, QuerySerializable {
  static func deserialize(response: HTTPURLResponse, body: Any?) -> Date {
    // TODO: check service date format
    
    let format = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    let formatter = DateFormatter()
    formatter.dateFormat = format
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    
    let str: String
    if let node = body as? XMLNode {
        str = node.stringValue!
    } else {
        str = body as! String
    }
    return formatter.date(from: str)!
  }
    
    /*
     https://github.com/aws/aws-sdk-go/blob/25fa088918bba994b0f4ad6537739f7e88d9a7f8/private/model/api/shape.go#L349
     if ref.Shape.Type == "timestamp" {
         t := ShapeTag{Key: "timestampFormat"}
         if ref.Location == "header" {
             t.Val = "rfc822"
         } else {
             switch ref.API.Metadata.Protocol {
             case "json", "rest-json":
                 t.Val = "unix"
             case "rest-xml", "ec2", "query":
                 t.Val = "iso8601"
             }
         }
         tags = append(tags, t)
     }
 */
    
    func restJsonSerialize() -> RestJsonFieldValue {
        return .date(self)
    }
    
  func restXmlSerialize() -> RestXmlFieldValue {
    return RestXmlFieldValue(node: XMLNode.text(withStringValue: "") as! XMLNode)
  }

    func querySerialize() -> QueryFieldValue {
        return .string("")
    }
}
extension Data: RestJsonSerializable, AwswiftDeserializable, QuerySerializable {
  static func deserialize(response: HTTPURLResponse, body: Any?) -> Data {
    return (body as! String).data(using: .utf8)!
  }
    
    func restJsonSerialize() -> RestJsonFieldValue {
        return .data(self)
    }
    
    func querySerialize() -> QueryFieldValue {
        return .string("")
    }

  func restXmlSerialize() -> RestXmlFieldValue {
    return RestXmlFieldValue(node: XMLNode.text(withStringValue: "") as! XMLNode)
  }
}
