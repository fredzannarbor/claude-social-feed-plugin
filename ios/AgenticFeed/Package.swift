// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AgenticFeed",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "AgenticFeed",
            targets: ["AgenticFeed"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "AgenticFeed",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "AgenticFeedTests",
            dependencies: ["AgenticFeed"],
            path: "Tests"
        ),
    ]
)
