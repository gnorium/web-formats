// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "WebFormats",
    platforms: [
        .macOS(.v14),
        .iOS(.v17),
        .watchOS(.v10),
        .tvOS(.v17),
        .visionOS(.v1)
    ],
    products: [
        .library(name: "JSONFormat", targets: ["JSONFormat"]),
        .library(name: "JSONLDFormat", targets: ["JSONLDFormat"]),
        .library(name: "JSONImportMapFormat", targets: ["JSONImportMapFormat"]),
        .library(name: "WAMFormat", targets: ["WAMFormat"]),
    ],
    dependencies: [
        .package(url: "https://github.com/gnorium/web-types", branch: "main")
    ],
    targets: [
        .target(
            name: "JSONFormat",
            dependencies: [],
            path: "Sources/WebFormats/JSONFormat",
            swiftSettings: [
                .enableUpcomingFeature("ExistentialAny"),
                .enableUpcomingFeature("StrictConcurrency")
            ]
        ),
        .target(
            name: "JSONLDFormat",
            dependencies: ["JSONFormat"],
            path: "Sources/WebFormats/JSONLDFormat",
            swiftSettings: [
                .enableUpcomingFeature("ExistentialAny"),
                .enableUpcomingFeature("StrictConcurrency")
            ]
        ),
        .target(
            name: "JSONImportMapFormat",
            dependencies: ["JSONFormat"],
            path: "Sources/WebFormats/JSONImportMapFormat",
            swiftSettings: [
                .enableUpcomingFeature("ExistentialAny"),
                .enableUpcomingFeature("StrictConcurrency")
            ]
        ),
        .target(
            name: "WAMFormat",
            dependencies: [
                .product(name: "WebTypes", package: "web-types")
            ],
            path: "Sources/WebFormats/WAMFormat",
            swiftSettings: [
                .enableUpcomingFeature("ExistentialAny"),
                .enableUpcomingFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "WebFormatsTests",
            dependencies: ["JSONFormat", "JSONLDFormat", "JSONImportMapFormat", "WAMFormat"]
        ),
    ]
)
