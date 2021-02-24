// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UI",
    platforms: [.iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)],
    products: [
        .library(name: "UI", targets: ["UI"])
    ],
    dependencies: [
        .package(name: "GameLogic", path: "../GameLogic"),
        .package(name: "DumbOpponent", path: "../DumbOpponent"),
        .package(name: "IntelligentOpponent", path: "../IntelligentOpponent")
    ],
    targets: [
        .target(name: "UI", dependencies: ["DumbOpponent", "IntelligentOpponent", "GameLogic"])
    ]
)
