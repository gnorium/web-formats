import JSONFormat

public protocol JSONImportMapFormattable: JSONFormattable {}

public func formatJSONImportMap<T: JSONImportMapFormattable>(_ content: () -> T) -> String {
  content().format()
}
