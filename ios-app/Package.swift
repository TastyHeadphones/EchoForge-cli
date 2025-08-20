// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "EchoForge",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "EchoForge",
            targets: ["EchoForge"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/firebase/firebase-ios-sdk.git",
            from: "10.0.0"
        ),
    ],
    targets: [
        .target(
            name: "EchoForge",
            dependencies: [
                .product(name: "FirebaseCore", package: "firebase-ios-sdk"),
                .product(name: "FirebaseVertexAI", package: "firebase-ios-sdk"),
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk")
            ]
        ),
    ]
)