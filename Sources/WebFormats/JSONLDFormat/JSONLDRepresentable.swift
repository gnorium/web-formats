#if !os(WASI)

import JSONFormat

public protocol JSONLDRepresentable: JSONRepresentable {
	var context: String? { get }
	var type: String? { get }
}

#endif
