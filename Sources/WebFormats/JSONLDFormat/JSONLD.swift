#if !os(WASI)

import JSONFormat

public protocol JSONLD: JSON {
	var context: String? { get }
	var type: String? { get }
}

#endif
