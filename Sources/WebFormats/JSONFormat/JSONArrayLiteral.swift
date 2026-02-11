#if !os(WASI)

import Foundation

public struct JSONArrayLiteral: JSONProtocol, Sendable {
	let array: [JSONValue]

	public init(_ array: [JSONValue]) {
		self.array = array
	}

	public init(_ array: [Any]) {
		self.array = array.map(anyToJSONValue)
	}

	public func encodeJSON() -> String {
		let items = array.map { $0.encodeJSON() }.joined(separator: ",")
		return "[\(items)]"
	}
}

#endif
