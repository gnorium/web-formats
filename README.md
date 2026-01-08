# WebFormats, as used in [gnorium.com](https://gnorium.com)

Structured data format builders for Swift, enabling declarative construction of JSON, JSON-LD, JSON import maps, and Web Application Manifest formats.

## Overview

WebFormats provides type-safe builders for common web data formats, allowing you to construct structured data using Swift's result builder syntax.

## Features

- **JSON Format**: Type-safe JSON object and array construction
- **JSON-LD Format**: Linked Data and schema.org markup
- **JSON Import Map Format**: ES module import map generation
- **WAM Format**: Web Application Manifest format

## Installation

### Swift Package Manager

Add WebFormats to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/gnorium/web-formats", from: "1.0.0")
]
```

Then add it to your target dependencies:

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "WebFormats", package: "web-formats")
    ]
)
```

## Usage

```swift
import JSONFormat
import JSONLDFormat
import JSONImportMapFormat

// Build JSON-LD for structured data
let jsonLD = script {
    [
        .context: "https://schema.org",
        .type: "WebSite",
        .name: "Gnorium",
        .url: "https://gnorium.com"
    ] as JSONLDObject
}.type("application/ld+json")

// Build import map for ES modules
let importMap = script {
    JSONImportMap(imports: [
        "three": "https://cdn.jsdelivr.net/npm/three@0.160.0/build/three.module.js"
    ]).encodeJSON()
}.type("importmap")
```

## Requirements

- Swift 6.2+

## License

Apache License 2.0 - See [LICENSE](LICENSE) for details

## Contributing

Contributions welcome! Please open an issue or submit a pull request.

## Related Packages

- [design-tokens](https://github.com/gnorium/design-tokens) - Universal design tokens based on Apple HIG
- [embedded-swift-utilities](https://github.com/gnorium/embedded-swift-utilities) - Utilities for Embedded Swift
- [web-administrator](https://github.com/gnorium/web-administrator) - Web administration panel for applications
- [web-apis](https://github.com/gnorium/web-apis) - Web API implementations for Swift WebAssembly
- [web-builders](https://github.com/gnorium/web-builders) - HTML, CSS, JS, and SVG DSL builders
- [web-components](https://github.com/gnorium/web-components) - Reusable UI components for web applications
- [web-types](https://github.com/gnorium/web-types) - Shared web types and design tokens