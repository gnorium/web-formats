// swift-tools-version: 6.0

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
        .library(
            name: "WebFormats",
            targets: ["WebFormats"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/gnorium/web-types", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "WebFormats",
            dependencies: [
                .product(name: "WebTypes", package: "web-types")
            ],
            swiftSettings: [
                .enableUpcomingFeature("BareSlashRegexLiterals"),
                .enableUpcomingFeature("ConciseMagicFile"),
                .enableUpcomingFeature("ExistentialAny"),
                .enableUpcomingFeature("ForwardTrailingClosures"),
                .enableUpcomingFeature("ImplicitOpenExistentials"),
                .enableUpcomingFeature("StrictConcurrency"),
                .unsafeFlags(["-warn-concurrency"], .when(configuration: .debug)),
            ]
        ),
        .testTarget(
            name: "WebFormatsTests",
            dependencies: ["WebFormats"]
        ),
    ]
)
