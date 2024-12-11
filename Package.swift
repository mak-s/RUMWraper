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
        .package(url: "https://github.com/bugsnag/bugsnag-cocoa", .upToNextMajor(from:"6.30.2")),
        .package(url: "https://github.com/DataDog/dd-sdk-ios", .upToNextMajor(from: "2.0.0")),
        .package(url: "https://github.com/Instabug/Instabug-SP", .upToNextMajor(from: "14.0.0")),
        .package(url: "https://github.com/embrace-io/embrace-apple-sdk", .upToNextMajor(from: "6.5.2"))
    ],
    targets: [
        .target(
            name: "RUMWrapper",
            dependencies: [
            ]
        ),
        .target(
            name: "BugsnagWrapper",
            dependencies: [
                .product(name: "Bugsnag", package: "bugsnag-cocoa"),
                .product(name: "BugsnagNetworkRequestPlugin", package: "bugsnag-cocoa"),
            ]
        ),
        .target(
            name: "DatadogWrapper",
            dependencies: [
                .product(name: "DatadogCore", package: "dd-sdk-ios"),
                .product(name: "DatadogRUM", package: "dd-sdk-ios"),
                .product(name: "DatadogWebViewTracking", package: "dd-sdk-ios"),
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
//        .testTarget(name: "BugsnagWrapperTests", dependencies: ["BugsnagWrapper"]),
//        .testTarget(name: "DatadogWrapperTests", dependencies: ["DatadogWrapper"]),
//        .testTarget(name: "EmbraceWrapperTests", dependencies: ["EmbraceWrapper"]),
//        .testTarget(name: "InstabugWrapperTests", dependencies: ["InstabugWrapper"])
    ]
)
