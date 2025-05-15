// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Credenza",
    platforms: [
        .iOS(.v17),
        .macOS(.v15),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Credenza",
            targets: ["Credenza"]),
    ],
    dependencies: [
        .package(url: "https://github.com/RevenueCat/purchases-ios.git", "5.4.0"..<"6.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Credenza",
            dependencies: [
               // Adding SwiftfulLogging as a dependency for this target
                .product(name: "RevenueCat", package: "purchases-ios")
            ]),
        .testTarget(
            name: "CredenzaTests",
            dependencies: ["Credenza"]
        ),
    ]
)
