#if !os(WASI)

public protocol JSONRepresentable: Sendable {
	func encodeJSON() -> String
}

#endif
