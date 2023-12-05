// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "aoc",
    platforms: [.macOS(.v13)],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "d1",
            path: "d1"
        ),
        .executableTarget(
            name: "d2",
            path: "d2"
        ),
        .executableTarget(
            name: "d3",
            path: "d3"
        ),
        .executableTarget(
            name: "d4",
            path: "d4"
        ),
        .testTarget(
            name: "d1Tests",
            dependencies: ["d1"]
        ),
        .testTarget(
            name: "d2Tests",
            dependencies: ["d2"]
        ),
        .testTarget(
            name: "d3Tests",
            dependencies: ["d3"]
        ),
        .testTarget(
            name: "d4Tests",
            dependencies: ["d4"]
        ),
    ]
)
