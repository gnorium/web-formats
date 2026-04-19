// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "web-formats",
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
        .package(url: "https://github.com/gnorium/web-types", branch: "main"),
        .package(url: "https://github.com/gnorium/embedded-swift-utilities", branch: "main")
    ],
    targets: [
        .target(
            name: "JSONFormat",
            dependencies: [
                .product(name: "EmbeddedSwiftUtilities", package: "embedded-swift-utilities")
            ],
            path: "Sources/WebFormats/JSONFormat",
            swiftSettings: [
                .enableExperimentalFeature("Embedded", .when(platforms: [.wasi])),
                .enableUpcomingFeature("ExistentialAny"),
                .enableUpcomingFeature("StrictConcurrency"),
                .define("CLIENT", .when(platforms: [.wasi])),
                .define("SERVER", .when(platforms: [.macOS, .linux, .windows]))
            ]
        ),
        .target(
            name: "JSONLDFormat",
            dependencies: [
                "JSONFormat",
                .product(name: "EmbeddedSwiftUtilities", package: "embedded-swift-utilities")
            ],
            path: "Sources/WebFormats/JSONLDFormat",
            swiftSettings: [
                .enableExperimentalFeature("Embedded", .when(platforms: [.wasi])),
                .enableUpcomingFeature("ExistentialAny"),
                .enableUpcomingFeature("StrictConcurrency"),
                .define("CLIENT", .when(platforms: [.wasi])),
                .define("SERVER", .when(platforms: [.macOS, .linux, .windows]))
            ]
        ),
        .target(
            name: "JSONImportMapFormat",
            dependencies: [
                "JSONFormat",
                .product(name: "EmbeddedSwiftUtilities", package: "embedded-swift-utilities")
            ],
            path: "Sources/WebFormats/JSONImportMapFormat",
            swiftSettings: [
                .enableExperimentalFeature("Embedded", .when(platforms: [.wasi])),
                .enableUpcomingFeature("ExistentialAny"),
                .enableUpcomingFeature("StrictConcurrency"),
                .define("CLIENT", .when(platforms: [.wasi])),
                .define("SERVER", .when(platforms: [.macOS, .linux, .windows]))
            ]
        ),
        .target(
            name: "WAMFormat",
            dependencies: [
                .product(name: "WebTypes", package: "web-types"),
                .product(name: "EmbeddedSwiftUtilities", package: "embedded-swift-utilities")
            ],
            path: "Sources/WebFormats/WAMFormat",
            swiftSettings: [
                .enableExperimentalFeature("Embedded", .when(platforms: [.wasi])),
                .enableUpcomingFeature("ExistentialAny"),
                .enableUpcomingFeature("StrictConcurrency"),
                .define("CLIENT", .when(platforms: [.wasi])),
                .define("SERVER", .when(platforms: [.macOS, .linux, .windows]))
            ]
        ),
        .testTarget(
            name: "WebFormatsTests",
            dependencies: ["JSONFormat", "JSONLDFormat", "JSONImportMapFormat", "WAMFormat"]
        ),
    ]
)
