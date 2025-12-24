#if !os(WASI)

import Foundation
import WebTypes

public struct WAM {
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
				      let url = shortcutDict["url"] as? String else { return nil }
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

	public func toDictionary() -> [String: Any] {
		var dict: [String: Any] = [:]

		if let backgroundColor = backgroundColor { dict["background_color"] = backgroundColor }
		if let categories = categories { dict["categories"] = categories }
		if let description = description { dict["description"] = description }
		if let dir = dir { dict["dir"] = dir.rawValue }
		if let display = display { dict["display"] = display.rawValue }
		if let icons = icons { dict["icons"] = icons.map { $0.toDictionary() } }
		if let iarc_rating_id = iarc_rating_id { dict["iarc_rating_id"] = iarc_rating_id }
		if let id = id { dict["id"] = id }
		if let lang = lang { dict["lang"] = lang }
		if let name = name { dict["name"] = name }
		if let orientation = orientation { dict["orientation"] = orientation.rawValue }
		if let preferRelatedApplications = preferRelatedApplications { dict["prefer_related_applications"] = preferRelatedApplications }
		if let relatedApplications = relatedApplications { dict["related_applications"] = relatedApplications }
		if let scope = scope { dict["scope"] = scope }
		if let screenshots = screenshots { dict["screenshots"] = screenshots.map { $0.toDictionary() } }
		if let shortName = shortName { dict["short_name"] = shortName }
		if let shortcuts = shortcuts { dict["shortcuts"] = shortcuts.map { $0.toDictionary() } }
		if let startUrl = startUrl { dict["start_url"] = startUrl }
		if let themeColor = themeColor { dict["theme_color"] = themeColor }

		return dict
	}

	public func toJSON() -> String {
		let dict = toDictionary()
		return renderJSON(dict)
	}

	private func renderJSON(_ value: Any, indent: Int = 0) -> String {
		let ind = String(repeating: "  ", count: indent)

		if let dict = value as? [String: Any] {
			if dict.isEmpty { return "{}" }
			let pairs = dict.map { key, val in
				"\(ind)  \"\(key)\": \(renderJSON(val, indent: indent + 1))"
			}.joined(separator: ",\n")
			return "{\n\(pairs)\n\(ind)}"
		} else if let array = value as? [Any] {
			if array.isEmpty { return "[]" }
			let items = array.map { renderJSON($0, indent: indent + 1) }.joined(separator: ",\n\(ind)  ")
			return "[\n\(ind)  \(items)\n\(ind)]"
		} else if let string = value as? String {
			return "\"\(string.replacingOccurrences(of: "\"", with: "\\\""))\""
		} else if let number = value as? Int {
			return "\(number)"
		} else if let number = value as? Double {
			return "\(number)"
		} else if let bool = value as? Bool {
			return bool ? "true" : "false"
		} else {
			return "null"
		}
	}
}

#endif
