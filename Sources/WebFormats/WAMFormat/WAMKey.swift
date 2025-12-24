#if !os(WASI)

public enum WAMKey: String {
	case name
	case shortName = "short_name"
	case description
	case startUrl = "start_url"
	case display
	case orientation
	case themeColor = "theme_color"
	case backgroundColor = "background_color"
	case categories
	case icons
	case iarc_rating_id
	case preferRelatedApplications = "prefer_related_applications"
	case relatedApplications = "related_applications"
	case screenshots
	case shortcuts
	case scope
	case id
	case dir
	case lang
}

#endif
