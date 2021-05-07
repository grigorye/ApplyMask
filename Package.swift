// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "ApplyMask",
    products: [
        .executable(
            name: "ApplyMask",
            targets: ["ApplyMask"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.0.5"),
    ],
    targets: [
        .target(
            name: "ApplyMask",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]
        )
    ]
)
