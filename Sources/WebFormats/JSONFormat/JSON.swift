#if !os(WASI)

public protocol JSON: Sendable {
	func encodeJSON() -> String
}

#endif
