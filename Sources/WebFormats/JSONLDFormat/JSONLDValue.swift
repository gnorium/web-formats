#if !os(WASI)

public struct JSONLDValue: ExpressibleByNilLiteral {
	let value: String

	init(_ type: JSONLDType) {
		self.value = type.rawValue
	}

	public init(nilLiteral: ()) {
		self.value = ""
	}

	// Static properties for type values
	public static var webSite: JSONLDValue { JSONLDValue(.webSite) }
	public static var searchAction: JSONLDValue { JSONLDValue(.searchAction) }
	public static var entryPoint: JSONLDValue { JSONLDValue(.entryPoint) }
	public static var propertyValueSpecification: JSONLDValue { JSONLDValue(.propertyValueSpecification) }
	public static var organization: JSONLDValue { JSONLDValue(.organization) }
	public static var person: JSONLDValue { JSONLDValue(.person) }
	public static var article: JSONLDValue { JSONLDValue(.article) }
	public static var blogPosting: JSONLDValue { JSONLDValue(.blogPosting) }
	public static var breadcrumbList: JSONLDValue { JSONLDValue(.breadcrumbList) }
	public static var listItem: JSONLDValue { JSONLDValue(.listItem) }
	public static var imageObject: JSONLDValue { JSONLDValue(.imageObject) }
	public static var videoObject: JSONLDValue { JSONLDValue(.videoObject) }
	public static var webPage: JSONLDValue { JSONLDValue(.webPage) }
}

#endif
