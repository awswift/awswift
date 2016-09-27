extension Dictionary {
  init<S: Sequence>(_ seq: S) where S.Iterator.Element == Element {
    self.init()
    self.merge(seq)
  }
  
  mutating func merge<S: Sequence>(_ seq: S) where S.Iterator.Element == Element {
    var gen = seq.makeIterator()
    while let (key, value) = gen.next() {
      self[key] = value
    }
  }
}

extension String {
  func lowercaseFirst() -> String {
    let first = characters.prefix(1)
    let remainder = self.characters.dropFirst()
    return String(first).lowercased() + String(remainder)
  }
}

public extension Sequence {
  func categorise<U : Hashable>(_ key: (Iterator.Element) -> U) -> [U:[Iterator.Element]] {
    var dict: [U:[Iterator.Element]] = [:]
    for el in self {
      let key = key(el)
      if case nil = dict[key]?.append(el) { dict[key] = [el] }
    }
    return dict
  }
}
