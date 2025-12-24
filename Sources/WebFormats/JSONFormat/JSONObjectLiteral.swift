#if !os(WASI)

public struct JSONObjectLiteral: JSON, Sendable {
	let dict: [String: JSONValue]

	public init(_ dict: [String: JSONValue]) {
		self.dict = dict
	}

	public init(_ dict: [String: Any]) {
		self.dict = dict.mapValues { anyToJSONValue($0) }
	}

	public func encodeJSON() -> String {
		let pairs = dict.map { key, value in
			"\"\(key)\":\(value.encodeJSON())"
		}.joined(separator: ",")
		return "{\(pairs)}"
	}
}

// Helper to convert Any to JSONValue
func anyToJSONValue(_ value: Any) -> JSONValue {
	switch value {
	case let v as String: return .string(v)
	case let v as Int: return .number(Double(v))
	case let v as Double: return .number(v)
	case let v as Bool: return .bool(v)
	case let v as [Any]: return .array(v.map(anyToJSONValue))
	case let v as [String: Any]:
		return .object(v.mapValues(anyToJSONValue))
	default: return .null
	}
}

#endif
