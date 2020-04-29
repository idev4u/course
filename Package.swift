// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "course",
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.3.0"),

        // 🍃 An expressive, performant, and extensible templating language built for Swift.
        .package(url: "https://github.com/vapor/leaf.git", from: "3.0.2"),
        // Fluent
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "1.0.0" ),
        // Async
        .package(url: "https://github.com/vapor/core.git", from: "3.10.0"),
        // Image Resizing
        .package(url: "https://github.com/twostraws/SwiftGD.git", "2.0.0"..."2.4.0" ),
    ],
    targets: [
        .target(name: "App", dependencies: ["Leaf", "Vapor", "FluentPostgreSQL", "Async", "SwiftGD"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)

