import EmbeddedSwiftUtilities

public struct JSONArray: JSONFormattable, ExpressibleByArrayLiteral, @unchecked Sendable {
  public let array: [JSON]

  public init(_ array: [JSON]) {
    self.array = array
  }

  public init(arrayLiteral elements: JSON...) {
    self.array = elements
  }

  public func format() -> String {
    let items = stringJoin(array.map { $0.format() }, separator: ",")
    return "[\(items)]"
  }
}

// Allow casting from Array to JSONFormattable
extension Array: JSONFormattable where Element: JSONFormattable {
  public func format() -> String {
    let items = stringJoin(self.map { $0.format() }, separator: ",")
    return "[\(items)]"
  }
}

// Basic type conformances
extension String: JSONFormattable {
  public func format() -> String {
    return "\"\(jsonEscapeString(self))\""
  }
}

extension Double: JSONFormattable {
  public func format() -> String {
    return doubleToString(self)
  }
}

extension Int: JSONFormattable {
  public func format() -> String {
    return intToString(self)
  }
}

extension Bool: JSONFormattable {
  public func format() -> String {
    return self ? "true" : "false"
  }
}
