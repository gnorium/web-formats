#if !os(WASI)

import Foundation
import JSONFormat

/// Import map for ES module resolution
/// Conforms to the Import Maps specification: https://github.com/WICG/import-maps
public struct JSONImportMap: JSONProtocol, Sendable {
	let imports: [String: String]

	public init(imports: [String: String]) {
		self.imports = imports
	}

	public func encodeJSON() -> String {
		var result = "{\n"
		result += "  \"imports\": {\n"

		let importEntries = imports.map { key, value in
			"    \"\(key)\": \"\(value)\""
		}.joined(separator: ",\n")

		result += importEntries
		result += "\n  }\n"
		result += "}"

		return result
	}
}

#endif
