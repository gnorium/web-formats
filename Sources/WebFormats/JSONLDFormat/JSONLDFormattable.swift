import JSONFormat

public protocol JSONLDFormattable: JSONFormattable {
  var context: String? { get }
  var type: String? { get }
}

public func formatJSONLD<T: JSONLDFormattable>(_ content: () -> T) -> String {
  content().format()
}
