public protocol JSONFormattable: Sendable {
  func format() -> String
}

/// Direct formatter for objects - preserves beautiful [:] syntax while avoiding Dictionary normalization triggers.
public func formatJSON(_ object: JSONObject) -> String {
  object.format()
}

/// Direct formatter for arrays.
public func formatJSON(_ array: JSONArray) -> String {
  array.format()
}

/// Direct formatter for JSONDictionary (safe Dictionary alternative).
public func formatJSON<V: JSONFormattable>(_ dict: [FastString: V]) -> String {
  dict.format()
}

/// Closure-based formatter for objects (normalization-free).
public func formatJSON(_ content: () -> JSONObject) -> String {
  content().format()
}

/// Closure-based formatter for arrays (normalization-free).
public func formatJSON(_ content: () -> JSONArray) -> String {
  content().format()
}

/// Closure-based formatter for JSONDictionary (safe Dictionary alternative).
public func formatJSON<V: JSONFormattable>(_ content: () -> [FastString: V]) -> String {
  content().format()
}

/// Fallback for other JSONFormattable types.
public func formatJSON<T: JSONFormattable>(_ content: () -> T) -> String {
  content().format()
}
