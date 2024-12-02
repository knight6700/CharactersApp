// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private let packageDependancies: [Package.Dependency] = [
    .package(
        url: "https://github.com/pointfreeco/swift-snapshot-testing",
        from: "1.16.0"
    ),
    .package(url: "https://github.com/onevcat/Kingfisher", from: "8.1.1"),
    .package(url: "https://github.com/lukepistrol/SwiftLintPlugin", from: "0.2.2"),
]
private let products: [Product] = [
    .library(
        name: "AppFeature",
        targets: ["AppFeature"]
    ),
    .library(
        name: "DesignComponent",
        targets: ["DesignComponent"]
    ),
    .library(
        name: "Router",
        targets: ["Router"]
    ),
    .library(
        name: "Models",
        targets: ["Models"]
    ),
    .library(
        name: "NetworkHorizon",
        targets: ["NetworkHorizon"]
    ),
]
private let swiftLintPlugin: [Target.PluginUsage]? = [
    .plugin(name: "SwiftLint", package: "SwiftLintPlugin")
]
private let designComponent: Target.Dependency = "DesignComponent"
private let ROUTER: Target.Dependency = "Router"
private let MODELS: Target.Dependency = "Models"
private let NETWORK: Target.Dependency = "NetworkHorizon"
private let kingFisher: Target.Dependency = .product(
    name: "Kingfisher",
    package: "Kingfisher"
)

let package = Package(
    name: "CharacterCore",
    defaultLocalization: .init("en"),
    platforms: [.iOS(.v17)],
    products: products,
    dependencies: packageDependancies,
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "AppFeature",
            dependencies: [
                designComponent,
                ROUTER,
                MODELS,
                kingFisher,
                NETWORK,
            ],
            resources: [],
            swiftSettings: [
                .define("DEBUG", .when(configuration: .debug))
            ],
            plugins: swiftLintPlugin
        ),
        .target(
            name: "NetworkHorizon",
            dependencies: [],
            resources: [],
            plugins: swiftLintPlugin
        ),
        .target(
            name: "DesignComponent",
            dependencies: [
                MODELS,
                kingFisher,
            ],
            resources: [],
            plugins: swiftLintPlugin
        ),
        .target(
            name: "Models",
            dependencies: [],
            resources: []
        ),
        .target(
            name: "Router",
            dependencies: [
                MODELS
            ],
            resources: [],
            plugins: swiftLintPlugin
        ),
        .testTarget(
            name: "CharacterSnapShotTests",
            dependencies: [
                "AppFeature",
                designComponent,
                kingFisher,
                .product(
                    name: "SnapshotTesting",
                    package: "swift-snapshot-testing"
                ),
            ]
        ),
        .testTarget(
            name: "CharacterCoreTests",
            dependencies: ["AppFeature"]
        ),
    ],
    swiftLanguageVersions: [.version("5.9")]
)
