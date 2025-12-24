#if !os(WASI)

public enum JSONLDType: String {
	case webSite = "WebSite"
	case searchAction = "SearchAction"
	case entryPoint = "EntryPoint"
	case propertyValueSpecification = "PropertyValueSpecification"
	case organization = "Organization"
	case person = "Person"
	case article = "Article"
	case blogPosting = "BlogPosting"
	case breadcrumbList = "BreadcrumbList"
	case listItem = "ListItem"
	case imageObject = "ImageObject"
	case videoObject = "VideoObject"
	case webPage = "WebPage"
	case aboutPage = "AboutPage"
	case contactPage = "ContactPage"
	case faqPage = "FAQPage"
	case profilePage = "ProfilePage"
	case searchResultsPage = "SearchResultsPage"
}

#endif
