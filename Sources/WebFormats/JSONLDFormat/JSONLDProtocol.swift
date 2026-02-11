#if !os(WASI)

import JSONFormat

public protocol JSONLDProtocol: JSONProtocol {
	var context: String? { get }
	var type: String? { get }
}

#endif
