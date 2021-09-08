// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "SwiftPwned",
    platforms: [
       .macOS(.v10_15)
    ],
    products: [
        .library(name: "SwiftPwned", targets: ["SwiftPwned"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", .branch("async-await"))
    ],
    targets: [
        .target(name: "SwiftPwned", dependencies: [
            .product(name: "Vapor", package: "vapor"),
        ]),
        .testTarget(name: "SwiftPwnedTests", dependencies: [
            .target(name: "SwiftPwned")
        ])
    ]
)
