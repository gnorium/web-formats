import JSONFormat
import EmbeddedSwiftUtilities

/// Import map for ES module resolution
/// Conforms to the Import Maps specification: https://github.com/WICG/import-maps
public struct JSONImportMap: JSONImportMapFormattable, Sendable {
  let imports: [(String, String)]

  public init(imports: [String: String]) {
    var pairs: [(String, String)] = []
    for (key, val) in imports { pairs.append((key, val)) }
    self.imports = pairs
  }

  public init(imports: [(String, String)]) {
    self.imports = imports
  }

  public func format() -> String {
    let importPairs = imports.map { key, value in
      "\"\(key)\":\"\(value)\""
    }
    let importsJson = "{\"imports\":{\(stringJoin(importPairs, separator: ","))}}"
    return importsJson
  }
}
