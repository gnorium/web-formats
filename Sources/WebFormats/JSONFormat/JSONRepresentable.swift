#if SERVER

public protocol JSONRepresentable: Sendable {
	func encodeJSON() -> String
}

#endif
