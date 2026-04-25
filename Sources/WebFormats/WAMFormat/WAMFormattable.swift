#if SERVER
  import JSONFormat

  public protocol WAMFormattable: JSONFormattable {}

  public func formatWAM<T: WAMFormattable>(_ content: () -> T) -> String {
    content().format()
  }
#endif
