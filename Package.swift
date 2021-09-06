// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Custom-Label-Format-Swift",
    products: [
        .library(
            name: "Custom-Label-Format-Swift",
            targets: ["Custom-Label-Format-Swift"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Custom-Label-Format-Swift",
            dependencies: []),
        .testTarget(
            name: "Custom-Label-Format-SwiftTests",
            dependencies: ["Custom-Label-Format-Swift"],
            resources: [
                .copy("Resources/group1.identity"),
                .copy("Resources/test1.clabel")

            ]),
    ]
)
