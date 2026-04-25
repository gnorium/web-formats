#if SERVER
  public enum WAMDisplayMode: String, Sendable {
    case fullscreen
    case standalone
    case minimalUi = "minimal-ui"
    case browser
  }
#endif
