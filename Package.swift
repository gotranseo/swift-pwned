// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "SwiftPwned",
    products: [
        .library(
            name: "SwiftPwned",
            targets: ["SwiftPwned"]),
    ],
    dependencies: [
         .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
    ],
    targets: [
        .target(
            name: "SwiftPwned",
            dependencies: ["Vapor"]),
        .testTarget(
            name: "SwiftPwnedTests",
            dependencies: ["SwiftPwned"]),
    ]
)
