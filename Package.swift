// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Xero",
    platforms: [
        .tvOS   (.v17),
        .iOS    ("17.4"),
        .macOS  (.v13),
        .macCatalyst(.v17)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
//        .library(
//            name: "XeroModels",
//            targets: ["Models"]),
        .library(
            name: "Xero",
            targets: ["Models", "API"]),
    ],
    dependencies: [.Presto, .PKAppInfo, .PKPrefs],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Models",
            dependencies: [.Presto, .PKAppInfo, .PKPrefs]),
        .target(
            name: "API",
            dependencies: [.Presto, .PKAppInfo, .PKPrefs, .target(name: "Models")]),

    ]
)
//--------------------------------------
// MARK: - DEPENDENCIES -
//--------------------------------------
fileprivate extension Package.Dependency {
    static let Presto: Package.Dependency = .package(
        url: .Presto,
        from: "1.0.0")
    static let PKAppInfo: Package.Dependency = .package(
        url: .PKAppInfo,
        from: "1.0.0")
    static let PKPrefs: Package.Dependency = .package(
        url: .PKPrefs,
        from: "1.0.0")
}
fileprivate extension Target.Dependency {
    static let Presto:  Target.Dependency = .product(
        name: "Presto",
        package: "Presto")
    static let PKAppInfo:  Target.Dependency = .product(
        name: "PKAppInfo",
        package: "PKAppInfo")
    static let PKPrefs:  Target.Dependency = .product(
        name: "PKPrefs",
        package: "PKPrefs")
}
fileprivate extension String {
    static let Presto: String = "https://github.com/Project-Academy/Presto"
    static let PKAppInfo: String = "https://github.com/Project-Academy/PKAppInfo"
    static let PKPrefs: String = "https://github.com/Project-Academy/PKPrefs"
}
