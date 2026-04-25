import JSONFormat
import EmbeddedSwiftUtilities

/// Type-safe dictionary for schema.org structured data
@dynamicMemberLookup
public struct JSONLD: ExpressibleByDictionaryLiteral, JSONLDFormattable, @unchecked Sendable {
  internal var properties: JSON

  public var context: String? {
    if case .object(let pairs) = properties {
      for (key, val) in pairs {
        if key == "@context", case .string(let str) = val { return str }
      }
    }
    return nil
  }

  public var type: String? {
    if case .object(let pairs) = properties {
      for (key, val) in pairs {
        if key == "@type", case .string(let str) = val { return str }
      }
    }
    return nil
  }

  public init(properties: JSON) {
    self.properties = properties
  }

  public init(dictionaryLiteral elements: (JSONLDKey, JSON)...) {
    self.properties = .object(elements.map { ($0.0.rawValue, $0.1) })
  }

  public subscript(key: JSONLDKey) -> JSON? {
    if case .object(let pairs) = properties {
      for (k, v) in pairs {
        if k == key.rawValue { return v }
      }
    }
    return nil
  }

  public subscript(dynamicMember key: String) -> JSON? {
    if case .object(let pairs) = properties {
      for (k, v) in pairs {
        if k == key { return v }
      }
    }
    return nil
  }

  public func format() -> String {
    properties.format()
  }
}

// Convert JSONLD types to JSON
extension JSON {
  public init(_ value: JSONLDType) { self = .string(value.rawValue) }
  public init(_ value: JSONLDValue) { self = .string(value.value) }
  public init(_ value: JSONLD) { self = value.properties }
}
