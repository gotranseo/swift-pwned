// swift-tools-version:5.2
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
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0")
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
