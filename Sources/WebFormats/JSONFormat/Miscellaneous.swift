import EmbeddedSwiftUtilities

public func prettifyJSON(_ json: String, indent: Int = 0) -> String {
  var result = ""
  var currentIndent = indent
  var inString = false
  var escaped = false

  // Using utf8 view to be 100% safe from Unicode normalization triggers
  for byte in json.utf8 {
    if escaped {
      result = "\(result)\(UnicodeScalar(byte))"
      escaped = false
      continue
    }

    if byte == 0x5C {  // \
      escaped = true
      result = "\(result)\\"
      continue
    }

    if byte == 0x22 {  // "
      inString.toggle()
      result = "\(result)\""
      continue
    }

    if inString {
      result = "\(result)\(UnicodeScalar(byte))"
      continue
    }

    switch byte {
    case 0x7B, 0x5B:  // { [
      result = "\(result)\(UnicodeScalar(byte))\n"
      currentIndent += 1
      for _ in 0..<currentIndent { result = "\(result)  " }
    case 0x7D, 0x5D:  // } ]
      result = "\(result)\n"
      currentIndent -= 1
      for _ in 0..<currentIndent { result = "\(result)  " }
      result = "\(result)\(UnicodeScalar(byte))"
    case 0x2C:  // ,
      result = "\(result),\n"
      for _ in 0..<currentIndent { result = "\(result)  " }
    case 0x3A:  // :
      result = "\(result): "
    case 0x20:  // space
      if !result.isEmpty && result.utf8.last == 0x20 {
        continue
      }
      result = "\(result) "
    default:
      result = "\(result)\(UnicodeScalar(byte))"
    }
  }

  return result
}
