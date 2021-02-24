// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DumbOpponent",
    platforms: [.iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)],
    products: [
        .library(name: "DumbOpponent", targets: ["DumbOpponent"])
    ],
    dependencies: [
        .package(name: "GameLogic", path: "../GameLogic")
    ],
    targets: [
        .target(name: "DumbOpponent", dependencies: ["GameLogic"]),
        .testTarget(name: "DumbOpponentTests", dependencies: ["DumbOpponent"])
    ]
)
