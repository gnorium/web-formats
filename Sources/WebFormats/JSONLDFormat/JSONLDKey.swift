#if !os(WASI)

public enum JSONLDKey: Hashable, ExpressibleByStringLiteral {
	// Meta keys
	case context
	case type
	case id

	// Property keys
	case name
	case description
	case url
	case potentialAction
	case target
	case queryInput
	case urlTemplate
	case valueName
	case valueRequired
	case logo
	case email
	case telephone
	case headline
	case author
	case datePublished
	case image
	case itemListElement
	case position
	case item
	case sameAs
	case jobTitle

	// Custom string key
	case custom(String)

	public var rawValue: String {
		switch self {
		case .context: return "@context"
		case .type: return "@type"
		case .id: return "@id"
		case .name: return "name"
		case .description: return "description"
		case .url: return "url"
		case .potentialAction: return "potentialAction"
		case .target: return "target"
		case .queryInput: return "query-input"
		case .urlTemplate: return "urlTemplate"
		case .valueName: return "valueName"
		case .valueRequired: return "valueRequired"
		case .logo: return "logo"
		case .email: return "email"
		case .telephone: return "telephone"
		case .headline: return "headline"
		case .author: return "author"
		case .datePublished: return "datePublished"
		case .image: return "image"
		case .itemListElement: return "itemListElement"
		case .position: return "position"
		case .item: return "item"
		case .sameAs: return "sameAs"
		case .jobTitle: return "jobTitle"
		case .custom(let str): return str
		}
	}

	public init(stringLiteral value: String) {
		self = .custom(value)
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(rawValue)
	}

	public static func == (lhs: JSONLDKey, rhs: JSONLDKey) -> Bool {
		lhs.rawValue == rhs.rawValue
	}
}

#endif
