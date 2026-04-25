import EmbeddedSwiftUtilities

/// A string wrapper that uses byte-level hashing and equality to avoid Unicode normalization triggers.
/// Safe for use as Dictionary keys in Embedded Swift (WASM).
public struct FastString: Hashable, ExpressibleByStringLiteral, @unchecked Sendable {
  public let string: String

  public init(_ string: String) {
    self.string = string
  }

  public init(stringLiteral value: String) {
    self.string = value
  }

  public func hash(into hasher: inout Hasher) {
    for byte in string.utf8 {
      hasher.combine(byte)
    }
  }

  public static func == (lhs: FastString, rhs: FastString) -> Bool {
    return stringEquals(lhs.string, rhs.string)
  }
}

extension Dictionary: JSONFormattable where Key == FastString, Value: JSONFormattable {
  public func format() -> String {
    let items = self.map { key, value in
      "\"\(jsonEscapeString(key.string))\":\(value.format())"
    }
    let renderedPairs = stringJoin(items, separator: ",")
    return "{\(renderedPairs)}"
  }
}
