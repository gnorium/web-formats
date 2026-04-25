import EmbeddedSwiftUtilities

public enum JSON: JSONFormattable, @unchecked Sendable {
  case string(String)
  case number(Double)
  case bool(Bool)
  case null
  case array([JSON])
  case object([(String, JSON)])

  public func format() -> String {
    switch self {
    case .string(let str):
      return "\"\(jsonEscapeString(str))\""
    case .number(let num):
      return doubleToString(num)
    case .bool(let b):
      return b ? "true" : "false"
    case .null:
      return "null"
    case .array(let arr):
      let items = stringJoin(arr.map { $0.format() }, separator: ",")
      return "[\(items)]"
    case .object(let pairs):
      let renderedPairs = stringJoin(
        pairs.map { "\"\(jsonEscapeString($0.0))\":\($0.1.format())" }, separator: ",")
      return "{\(renderedPairs)}"
    }
  }
}

// Convenience constructors from Swift types
extension JSON {
  public init(_ value: String) { self = .string(value) }
  public init(_ value: Int) { self = .number(Double(value)) }
  public init(_ value: Double) { self = .number(value) }
  public init(_ value: Bool) { self = .bool(value) }
  public init(_ value: [JSON]) { self = .array(value) }
  public init(_ value: [(String, JSON)]) { self = .object(value) }

  public init(_ value: [String: String]) {
    var pairs: [(String, JSON)] = []
    for (key, val) in value { pairs.append((key, .string(val))) }
    self = .object(pairs)
  }
  
  public init(_ value: [String]) {
    self = .array(value.map { .string($0) })
  }
  
  public init(_ value: [Int]) {
    self = .array(value.map { .number(Double($0)) })
  }
  
  public init(_ value: [Double]) {
    self = .array(value.map { .number($0) })
  }
  
  public init(_ value: [Bool]) {
    self = .array(value.map { .bool($0) })
  }

  public init(_ value: [String: Int]) {
    var pairs: [(String, JSON)] = []
    for (key, val) in value { pairs.append((key, .number(Double(val)))) }
    self = .object(pairs)
  }
}

extension JSON: ExpressibleByStringLiteral {
  public init(stringLiteral value: String) { self = .string(value) }
}

extension JSON: ExpressibleByFloatLiteral {
  public init(floatLiteral value: Double) { self = .number(value) }
}

extension JSON: ExpressibleByIntegerLiteral {
  public init(integerLiteral value: Int) { self = .number(Double(value)) }
}

extension JSON: ExpressibleByBooleanLiteral {
  public init(booleanLiteral value: Bool) { self = .bool(value) }
}

extension JSON: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: JSON...) { self = .array(elements) }
}

extension JSON: ExpressibleByDictionaryLiteral {
  public init(dictionaryLiteral elements: (String, JSON)...) {
    self = .object(elements)
  }
}
