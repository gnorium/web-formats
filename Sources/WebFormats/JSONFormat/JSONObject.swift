import EmbeddedSwiftUtilities

public struct JSONObject: JSONFormattable, ExpressibleByDictionaryLiteral, @unchecked Sendable {
  public let pairs: [(String, JSON)]

  public init(_ pairs: [(String, JSON)]) {
    self.pairs = pairs
  }

  public init(dictionaryLiteral elements: (String, JSON)...) {
    self.pairs = elements
  }

  public func format() -> String {
    let renderedPairs = stringJoin(
      pairs.map { key, value in
        "\"\(jsonEscapeString(key))\":\(value.format())"
      }, separator: ",")
    return "{\(renderedPairs)}"
  }
}

// NOTE: We do NOT provide an extension for standard Dictionary here.
// Doing so would allow Swift to infer [:] literals as Dictionary,
// which triggers Unicode normalization. By only providing JSONObject,
// we force literals to use the normalization-free buailder.
