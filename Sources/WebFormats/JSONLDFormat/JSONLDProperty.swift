#if !os(WASI)

public enum JSONLDProperty: String {
	// Common properties
	case context = "@context"
	case type = "@type"
	case id = "@id"

	// WebSite properties
	case name
	case description
	case url
	case potentialAction

	// SearchAction properties
	case target
	case queryInput = "query-input"

	// Organization/Person properties
	case logo
	case email
	case telephone
	case address
	case contactPoint

	// Article/BlogPosting properties
	case headline
	case author
	case datePublished
	case dateModified
	case image
	case publisher

	// BreadcrumbList properties
	case itemListElement
	case position
	case item

	// ImageObject properties
	case contentUrl
	case width
	case height
}


#endif
