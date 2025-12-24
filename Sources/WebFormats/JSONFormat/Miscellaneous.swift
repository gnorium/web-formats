#if !os(WASI)

public func formatJSON(_ json: String, indent: Int = 0) -> String {
	var result = ""
	var currentIndent = indent
	var inString = false
	var escaped = false

	for char in json {
		if escaped {
			result.append(char)
			escaped = false
			continue
		}

		if char == "\\" {
			escaped = true
			result.append(char)
			continue
		}

		if char == "\"" {
			inString.toggle()
			result.append(char)
			continue
		}

		if inString {
			result.append(char)
			continue
		}

		switch char {
		case "{", "[":
			result.append(char)
			result.append("\n")
			currentIndent += 1
			result.append(String(repeating: "  ", count: currentIndent))
		case "}", "]":
			result.append("\n")
			currentIndent -= 1
			result.append(String(repeating: "  ", count: currentIndent))
			result.append(char)
		case ",":
			result.append(char)
			result.append("\n")
			result.append(String(repeating: "  ", count: currentIndent))
		case ":":
			result.append(char)
			result.append(" ")
		case " " where result.last == " ":
			continue
		default:
			result.append(char)
		}
	}

	return result
}

#endif
