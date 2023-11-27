// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ListieModules",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
        .watchOS(.v10),
    ],
    products: [
        .library(
            name: "RootListFeature",
            targets: ["RootListFeature"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.5.0"),
        .package(url: "https://github.com/pointfreeco/swift-tagged.git", from: "0.10.0"),
    ],
    targets: [
        .target(
            name: "RootListFeature",
            dependencies: [
                "Models",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .testTarget(name: "RootListFeatureTests"),
        .target(
            name: "Models",
            dependencies: [
                .product(name: "Tagged", package: "swift-tagged"),
            ]
        ),
        .testTarget(name: "ModelsTests")
    ]
)
