// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RumWrapper",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "BugsnagWrapper",
            targets: ["BugsnagWrapper"]),
        .library(
            name: "DatadogWrapper",
            targets: ["DatadogWrapper"]),
        .library(
            name: "EmbraceWrapper",
            targets: ["EmbraceWrapper"]),
        .library(
            name: "InstabugWrapper",
            targets: ["InstabugWrapper"])
    ],
    dependencies: [
        .package(url: "https://github.com/bugsnag/bugsnag-cocoa", exact: "6.30.2"),
        .package(url: "https://github.com/DataDog/dd-sdk-ios", exact: "2.20.0"),
        .package(url: "https://github.com/Instabug/Instabug-SP", exact: "14.0.0"),
        .package(url: "https://github.com/embrace-io/embrace-apple-sdk", exact: "6.5.2"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "BugsnagWrapper",
            dependencies: [
                .product(name: "Bugsnag", package: "bugsnag-cocoa")
            ]
        ),
        .target(
            name: "DatadogWrapper",
            dependencies: [
                .product(name: "DatadogCore", package: "dd-sdk-ios"),
                .product(name: "DatadogRUM", package: "dd-sdk-ios")
            ]
        ),
        .target(
            name: "EmbraceWrapper",
            dependencies: [
                .product(name: "EmbraceCore", package: "embrace-apple-sdk"),
            ]
        ),
        .target(
            name: "InstabugWrapper",
            dependencies: [
                .product(name: "Instabug", package: "Instabug-SP"),
            ]
        ),
        .testTarget(name: "BugsnagWrapperTests", dependencies: ["BugsnagWrapper"]),
        .testTarget(name: "DatadogWrapperTests", dependencies: ["DatadogWrapper"]),
        .testTarget(name: "EmbraceWrapperTests", dependencies: ["EmbraceWrapper"]),
        .testTarget(name: "InstabugWrapperTests", dependencies: ["InstabugWrapper"])
    ]
)
