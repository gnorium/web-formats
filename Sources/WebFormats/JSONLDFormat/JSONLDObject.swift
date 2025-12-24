#if !os(WASI)

import JSONFormat

/// Type-safe dictionary for schema.org structured data
@dynamicMemberLookup
public struct JSONLDObject: ExpressibleByDictionaryLiteral, JSON, Sendable {
	internal var properties: [String: Any]

	public init(dictionaryLiteral elements: (JSONLDKey, Any)...) {
		self.properties = Dictionary(uniqueKeysWithValues: elements.map {
			let value: Any
			if let jsonldValue = $0.1 as? JSONLDValue {
				value = jsonldValue.value
			} else if let jsonldType = $0.1 as? JSONLDType {
				value = jsonldType.rawValue
			} else {
				value = $0.1
			}
			return ($0.0.rawValue, value)
		})
	}

	public subscript(key: JSONLDKey) -> Any? {
		get { properties[key.rawValue] }
		set { properties[key.rawValue] = newValue }
	}

	public subscript(dynamicMember key: String) -> Any? {
		get { properties[key] }
		set { properties[key] = newValue }
	}

	public func toDictionary() -> [String: Any] {
		convertToDictionary()
	}

	public func encodeJSON() -> String {
		let dict = convertToDictionary()
		return renderJSON(dict)
	}

	private func renderJSON(_ value: Any, indent: Int = 0) -> String {
		let ind = String(repeating: "  ", count: indent)

		if let dict = value as? [String: Any] {
			if dict.isEmpty { return "{}" }
			let pairs = dict.map { key, val in
				"\(ind)  \"\(key)\": \(renderJSON(val, indent: indent + 1))"
			}.joined(separator: ",\n")
			return "{\n\(pairs)\n\(ind)}"
		} else if let array = value as? [Any] {
			if array.isEmpty { return "[]" }
			let items = array.map { renderJSON($0, indent: indent + 1) }.joined(separator: ",\n\(ind)  ")
			return "[\n\(ind)  \(items)\n\(ind)]"
		} else if let string = value as? String {
			return "\"\(string.replacingOccurrences(of: "\"", with: "\\\""))\""
		} else if let number = value as? Int {
			return "\(number)"
		} else if let number = value as? Double {
			return "\(number)"
		} else if let bool = value as? Bool {
			return bool ? "true" : "false"
		} else {
			return "null"
		}
	}
}

extension JSONLDObject {
	func convertToDictionary() -> [String: Any] {
		var result: [String: Any] = [:]
		for (key, value) in properties {
			if let jsonldObj = value as? JSONLDObject {
				result[key] = jsonldObj.convertToDictionary()
			} else if let jsonldArray = value as? [JSONLDObject] {
				result[key] = jsonldArray.map { $0.convertToDictionary() }
			} else {
				result[key] = value
			}
		}
		return result
	}
}

#endif
