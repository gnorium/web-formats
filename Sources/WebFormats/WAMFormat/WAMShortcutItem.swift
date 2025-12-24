#if !os(WASI)

import WebTypes

public struct WAMShortcutItem {
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

	public func toDictionary() -> [String: Any] {
		var dict: [String: Any] = [
			"name": name,
			"url": url
		]
		if let shortName = shortName { dict["short_name"] = shortName }
		if let description = description { dict["description"] = description }
		if let icons = icons { dict["icons"] = icons.map { $0.toDictionary() } }
		return dict
	}
}

#endif
