#if !os(WASI)

public protocol JSONProtocol: Sendable {
	func encodeJSON() -> String
}

#endif
