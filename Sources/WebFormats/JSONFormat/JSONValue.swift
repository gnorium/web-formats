#if !os(WASI)

import Foundation

public enum JSONValue: JSON, Sendable {
	case string(String)
	case number(Double)
	case bool(Bool)
	case null
	case array([JSONValue])
	case object([String: JSONValue])

	public func encodeJSON() -> String {
		switch self {
		case .string(let str):
			let escaped = str
				.replacingOccurrences(of: "\\", with: "\\\\")
				.replacingOccurrences(of: "\"", with: "\\\"")
				.replacingOccurrences(of: "\n", with: "\\n")
				.replacingOccurrences(of: "\r", with: "\\r")
				.replacingOccurrences(of: "\t", with: "\\t")
			return "\"\(escaped)\""
		case .number(let num):
			return String(num)
		case .bool(let b):
			return b ? "true" : "false"
		case .null:
			return "null"
		case .array(let arr):
			let items = arr.map { $0.encodeJSON() }.joined(separator: ",")
			return "[\(items)]"
		case .object(let obj):
			let pairs = obj.map { "\"\($0.key)\":\($0.value.encodeJSON())" }.joined(separator: ",")
			return "{\(pairs)}"
		}
	}
}

// Convenience constructors from Swift types
extension JSONValue {
	public init(_ value: String) { self = .string(value) }
	public init(_ value: Int) { self = .number(Double(value)) }
	public init(_ value: Double) { self = .number(value) }
	public init(_ value: Bool) { self = .bool(value) }
	public init(_ value: [JSONValue]) { self = .array(value) }
	public init(_ value: [String: JSONValue]) { self = .object(value) }
}

#endif
