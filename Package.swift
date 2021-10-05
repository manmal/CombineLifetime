// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "CombineLifetime",
    platforms: [.iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)],
    products: [
        .library(
            name: "CombineLifetime",
            targets: ["CombineLifetime"]),
    ],
    targets: [
        .target(
            name: "CombineLifetime",
            dependencies: []),
        .testTarget(
            name: "CombineLifetimeTests",
            dependencies: ["CombineLifetime"]),
    ]
)
