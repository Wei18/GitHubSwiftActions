// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GitHubSwiftActions",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .executable(name: "Comment", targets: ["Comment"]),
        .executable(name: "Release", targets: ["Release"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Wei18/github-rest-api-swift-openapi", from: "2.0.0"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-openapi-runtime", from: "1.0.0"),
        .package(url: "https://github.com/jpsim/Yams", from: "5.0.0"),
    ],
    targets: [
        //
        .executableTarget(
            name: "Comment",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .target(name: "CommentCLI"),
            ]
        ),
        .target(
            name: "CommentCLI",
            dependencies: [
                .target(name: "CommentCore"),
                .target(name: "Extensions"),
            ]
        ),
        .target(
            name: "CommentCore",
            dependencies: [
                .product(name: "GitHubRestAPIIssues", package: "github-rest-api-swift-openapi"),
                .target(name: "Middleware"),
            ]
        ),
        //
        .executableTarget(
            name: "Release",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .target(name: "ReleaseCLI"),
            ]
        ),
        .target(
            name: "ReleaseCLI",
            dependencies: [
                .target(name: "ReleaseCore"),
                .target(name: "Extensions"),
            ]
        ),
        .target(
            name: "ReleaseCore",
            dependencies: [
                .product(name: "GitHubRestAPIRepos", package: "github-rest-api-swift-openapi"),
                .target(name: "Middleware"),
                .target(name: "Extensions"),
            ]
        ),
        .target(
            name: "Middleware",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
            ]
        ),
        .executableTarget(
            name: "YamlWriter",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Yams", package: "Yams"),
                .target(name: "CommentCLI"),
            ]
        ),
        .target(name: "Extensions")
    ]
)
