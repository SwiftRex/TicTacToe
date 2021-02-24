// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GameLogic",
    platforms: [.iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)],
    products: [
        .library(name: "GameLogic", targets: ["GameLogic"])
    ],
    dependencies: [
        .package(name: "SwiftRex", url: "https://github.com/SwiftRex/SwiftRex.git", .upToNextMajor(from: "0.8.2"))
    ],
    targets: [
        .target(name: "GameLogic", dependencies: [.product(name: "CombineRex", package: "SwiftRex")]),
        .testTarget(name: "GameLogicTests", dependencies: ["GameLogic"])
    ]
)
