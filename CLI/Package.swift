// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CLI",
    platforms: [.macOS(.v10_15)],
    products: [
        .executable(name: "TicTacToeCLI", targets: ["CLI"])
    ],
    dependencies: [
        .package(name: "GameLogic", path: "../GameLogic"),
        .package(name: "DumbOpponent", path: "../DumbOpponent")
    ],
    targets: [
        .target(name: "CLI", dependencies: ["GameLogic", "DumbOpponent"])
    ]
)
