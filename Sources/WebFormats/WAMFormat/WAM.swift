#if SERVER
  import Foundation
  import JSONFormat
  import WebTypes

  public struct WAM: WAMFormattable {
    public var backgroundColor: String?
    public var categories: [String]?
    public var description: String?
    public var dir: WAMTextDirection?
    public var display: WAMDisplayMode?
    public var icons: [ImageResource]?
    public var iarc_rating_id: String?
    public var id: String?
    public var lang: String?
    public var name: String?
    public var orientation: OrientationLockType?
    public var preferRelatedApplications: Bool?
    public var relatedApplications: [[String: String]]?
    public var scope: String?
    public var screenshots: [ImageResource]?
    public var shortName: String?
    public var shortcuts: [WAMShortcutItem]?
    public var startUrl: String?
    public var themeColor: String?

    public init(
      backgroundColor: String? = nil,
      categories: [String]? = nil,
      description: String? = nil,
      dir: WAMTextDirection? = nil,
      display: WAMDisplayMode? = nil,
      icons: [ImageResource]? = nil,
      iarc_rating_id: String? = nil,
      id: String? = nil,
      lang: String? = nil,
      name: String? = nil,
      orientation: OrientationLockType? = nil,
      preferRelatedApplications: Bool? = nil,
      relatedApplications: [[String: String]]? = nil,
      scope: String? = nil,
      screenshots: [ImageResource]? = nil,
      shortName: String? = nil,
      shortcuts: [WAMShortcutItem]? = nil,
      startUrl: String? = nil,
      themeColor: String? = nil
    ) {
      self.backgroundColor = backgroundColor
      self.categories = categories
      self.description = description
      self.dir = dir
      self.display = display
      self.icons = icons
      self.iarc_rating_id = iarc_rating_id
      self.id = id
      self.lang = lang
      self.name = name
      self.orientation = orientation
      self.preferRelatedApplications = preferRelatedApplications
      self.relatedApplications = relatedApplications
      self.scope = scope
      self.screenshots = screenshots
      self.shortName = shortName
      self.shortcuts = shortcuts
      self.startUrl = startUrl
      self.themeColor = themeColor
    }

    public init(dict: [String: Any]) {
      self.backgroundColor = dict["background_color"] as? String
      self.categories = dict["categories"] as? [String]
      self.description = dict["description"] as? String
      if let dirStr = dict["dir"] as? String {
        self.dir = WAMTextDirection(rawValue: dirStr)
      }
      if let displayStr = dict["display"] as? String {
        self.display = WAMDisplayMode(rawValue: displayStr)
      }
      if let iconsArray = dict["icons"] as? [[String: Any]] {
        self.icons = iconsArray.compactMap { iconDict in
          guard let src = iconDict["src"] as? String else { return nil }
          return ImageResource(
            src: src,
            sizes: iconDict["sizes"] as? String,
            type: iconDict["type"] as? String,
            purpose: iconDict["purpose"] as? String
          )
        }
      }
      self.iarc_rating_id = dict["iarc_rating_id"] as? String
      self.id = dict["id"] as? String
      self.lang = dict["lang"] as? String
      self.name = dict["name"] as? String
      if let orientationStr = dict["orientation"] as? String {
        self.orientation = OrientationLockType(rawValue: orientationStr)
      }
      self.preferRelatedApplications = dict["prefer_related_applications"] as? Bool
      self.relatedApplications = dict["related_applications"] as? [[String: String]]
      self.scope = dict["scope"] as? String
      if let screenshotsArray = dict["screenshots"] as? [[String: Any]] {
        self.screenshots = screenshotsArray.compactMap { iconDict in
          guard let src = iconDict["src"] as? String else { return nil }
          return ImageResource(
            src: src,
            sizes: iconDict["sizes"] as? String,
            type: iconDict["type"] as? String,
            purpose: iconDict["purpose"] as? String
          )
        }
      }
      self.shortName = dict["short_name"] as? String
      if let shortcutsArray = dict["shortcuts"] as? [[String: Any]] {
        self.shortcuts = shortcutsArray.compactMap { shortcutDict in
          guard let name = shortcutDict["name"] as? String,
            let url = shortcutDict["url"] as? String
          else { return nil }
          var icons: [ImageResource]? = nil
          if let iconsArray = shortcutDict["icons"] as? [[String: Any]] {
            icons = iconsArray.compactMap { iconDict in
              guard let src = iconDict["src"] as? String else { return nil }
              return ImageResource(
                src: src,
                sizes: iconDict["sizes"] as? String,
                type: iconDict["type"] as? String,
                purpose: iconDict["purpose"] as? String
              )
            }
          }
          return WAMShortcutItem(
            name: name,
            shortName: shortcutDict["short_name"] as? String,
            description: shortcutDict["description"] as? String,
            url: url,
            icons: icons
          )
        }
      }
      self.startUrl = dict["start_url"] as? String
      self.themeColor = dict["theme_color"] as? String
    }

    public func format() -> String {
      return toJSONObject().format()
    }

    public func toJSONObject() -> JSONObject {
      var pairs: [(String, JSON)] = []

      if let backgroundColor = backgroundColor {
        pairs.append(("background_color", .string(backgroundColor)))
      }
      if let categories = categories { pairs.append(("categories", .array(categories.map { .string($0) }))) }
      if let description = description { pairs.append(("description", .string(description))) }
      if let dir = dir { pairs.append(("dir", .string(dir.rawValue))) }
      if let display = display { pairs.append(("display", .string(display.rawValue))) }
      if let icons = icons {
        let iconsJSON = icons.map { icon -> JSON in
          var iconPairs: [(String, JSON)] = [("src", .string(icon.src))]
          if let sizes = icon.sizes { iconPairs.append(("sizes", .string(sizes))) }
          if let type = icon.type { iconPairs.append(("type", .string(type))) }
          if let purpose = icon.purpose { iconPairs.append(("purpose", .string(purpose))) }
          return .object(iconPairs)
        }
        pairs.append(("icons", .array(iconsJSON)))
      }
      if let iarc_rating_id = iarc_rating_id { pairs.append(("iarc_rating_id", .string(iarc_rating_id))) }
      if let id = id { pairs.append(("id", .string(id))) }
      if let lang = lang { pairs.append(("lang", .string(lang))) }
      if let name = name { pairs.append(("name", .string(name))) }
      if let orientation = orientation { pairs.append(("orientation", .string(orientation.rawValue))) }
      if let preferRelatedApplications = preferRelatedApplications {
        pairs.append(("prefer_related_applications", .bool(preferRelatedApplications)))
      }
      if let relatedApplications = relatedApplications {
        let appsJSON = relatedApplications.map { app -> JSON in
          var appPairs: [(String, JSON)] = []
          for (key, val) in app { appPairs.append((key, .string(val))) }
          return .object(appPairs)
        }
        pairs.append(("related_applications", .array(appsJSON)))
      }
      if let scope = scope { pairs.append(("scope", .string(scope))) }
      if let screenshots = screenshots {
        let screenshotsJSON = screenshots.map { icon -> JSON in
          var iconPairs: [(String, JSON)] = [("src", .string(icon.src))]
          if let sizes = icon.sizes { iconPairs.append(("sizes", .string(sizes))) }
          if let type = icon.type { iconPairs.append(("type", .string(type))) }
          if let purpose = icon.purpose { iconPairs.append(("purpose", .string(purpose))) }
          return .object(iconPairs)
        }
        pairs.append(("screenshots", .array(screenshotsJSON)))
      }
      if let shortName = shortName { pairs.append(("short_name", .string(shortName))) }
      if let shortcuts = shortcuts {
        pairs.append(("shortcuts", .array(shortcuts.map { .object($0.toJSONObject().pairs) })))
      }
      if let startUrl = startUrl { pairs.append(("start_url", .string(startUrl))) }
      if let themeColor = themeColor { pairs.append(("theme_color", .string(themeColor))) }

      return JSONObject(pairs)
    }
  }
#endif
