// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let swiftSettings: [SwiftSetting] = [
    .unsafeFlags(["-Xfrontend", "-strict-concurrency=complete"]),
    .unsafeFlags(["-Xfrontend", "-enable-actor-data-race-checks"], .when(configuration: .debug))
]

let package = Package(
    name: "ListieModules",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
        .watchOS(.v10),
        .visionOS(.v1)
    ],
    products: [
        .library(name: "RootListFeature", targets: ["RootListFeature"]),
        .library(name: "RootListItemFeature", targets: ["RootListItemFeature"]),
        .library(name: "Models", targets: ["Models"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", exact: "1.7.2"),
        .package(url: "https://github.com/pointfreeco/swift-tagged.git", from: "0.10.0"),
    ],
    targets: [
        .target(
            name: "RootListFeature",
            dependencies: [
                "Models",
                "RootListItemFeature",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ],
            swiftSettings: swiftSettings
        ),
        .testTarget(name: "RootListFeatureTests",
                    dependencies: [
                        "RootListFeature"
                    ]),
        .target(
            name: "RootListItemFeature",
            dependencies: [
                "Models",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ],
            swiftSettings: swiftSettings
        ),
        .testTarget(name: "RootListItemFeatureTests",
                   dependencies: [
                    "RootListItemFeature"
                   ]),
        .target(
            name: "Models",
            dependencies: [
                .product(name: "Tagged", package: "swift-tagged"),
            ],
            swiftSettings: swiftSettings
        ),
        .testTarget(name: "ModelsTests")
    ]
)
