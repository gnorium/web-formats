#if !os(WASI)

public enum WAMDisplayMode: String {
	case fullscreen
	case standalone
	case minimalUi = "minimal-ui"
	case browser
}

#endif
