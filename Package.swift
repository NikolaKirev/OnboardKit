// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "OnboardKit",
    platforms: [.iOS(.v11)],
    products: [
        .library(name: "OnboardKit",  targets: ["OnboardKit"])
    ],
    dependencies: [],
    targets: [
        .target(name: "OnboardKit", path: "OnboardKit")
    ]
)