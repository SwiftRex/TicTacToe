// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IntelligentOpponent",
    platforms: [.iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)],
    products: [
        .library(name: "IntelligentOpponent", targets: ["IntelligentOpponent"])
    ],
    dependencies: [
        .package(name: "GameLogic", path: "../GameLogic")
    ],
    targets: [
        .target(name: "IntelligentOpponent", dependencies: ["GameLogic"]),
        .testTarget(name: "IntelligentOpponentTests", dependencies: ["IntelligentOpponent"])
    ]
)
