// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "OnboardKit",
    products: [
        .library(name: "OnboardKit",  targets: ["OnboardKit"])
    ],
    dependencies: [],
    targets: [
        .target(name: "OnboardKit", path: "OnboardKit")
    ]
)