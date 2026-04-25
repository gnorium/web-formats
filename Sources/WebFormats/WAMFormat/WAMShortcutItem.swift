#if SERVER
  import JSONFormat
  import WebTypes

  public struct WAMShortcutItem: Sendable, JSONFormattable {
    public let name: String
    public let shortName: String?
    public let description: String?
    public let url: String
    public let icons: [ImageResource]?

    public init(
      name: String,
      shortName: String? = nil,
      description: String? = nil,
      url: String,
      icons: [ImageResource]? = nil
    ) {
      self.name = name
      self.shortName = shortName
      self.description = description
      self.url = url
      self.icons = icons
    }

    public func format() -> String {
      return toJSONObject().format()
    }

    public func toJSONObject() -> JSONObject {
      var pairs: [(String, JSON)] = [
        ("name", .string(name)),
        ("url", .string(url)),
      ]
      if let shortName = shortName { pairs.append(("short_name", .string(shortName))) }
      if let description = description { pairs.append(("description", .string(description))) }
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
      return JSONObject(pairs)
    }
  }
#endif
