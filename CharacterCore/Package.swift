// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

private let PackageDependancies:  [Package.Dependency] = [
    .package(
        url: "https://github.com/pointfreeco/swift-snapshot-testing",
        from: "1.16.0"
    ),
    .package(url: "https://github.com/onevcat/Kingfisher", from: "8.1.1")
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
    )
]
private let DESIGN_COMPONENTS: Target.Dependency = "DesignComponent"
private let ROUTER: Target.Dependency = "Router"
private let MODELS: Target.Dependency = "Models"
private let NETWORK: Target.Dependency = "NetworkHorizon"
private let KingFisher_Dependancy: Target.Dependency = .product(
    name: "Kingfisher",
    package: "Kingfisher"
)

let package = Package(
    name: "CharacterCore",
    defaultLocalization: .init("en"),
    platforms: [.iOS(.v17)],
    products: products,
    dependencies: PackageDependancies,
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "AppFeature",
            dependencies: [
                DESIGN_COMPONENTS,
                ROUTER,
                MODELS,
                KingFisher_Dependancy,
                NETWORK
            ],
            resources: [],
            swiftSettings: [
                .define("DEBUG", .when(configuration: .debug))
            ]
        ),
        .target(
            name: "NetworkHorizon",
            dependencies: [],
            resources: []
        ),
        .target(
            name: "DesignComponent",
            dependencies: [
                MODELS,
                KingFisher_Dependancy
            ],
            resources: []
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
            resources: []
        ),
        .testTarget(
            name: "CharacterSnapShotTests",
            dependencies: [
                "AppFeature",
                DESIGN_COMPONENTS,
                KingFisher_Dependancy,
                .product(
                    name: "SnapshotTesting",
                    package: "swift-snapshot-testing"
                )
            ]
        ),
        .testTarget(
            name: "CharacterCoreTests",
            dependencies: ["AppFeature"]
        ),
    ],
    swiftLanguageVersions: [.version("5.9")]
)
