// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "BeyondWordsPlayer",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "BeyondWordsPlayer",
            targets: ["BeyondWordsPlayer"]
        )
    ],
    targets: [
        .target(
            name: "BeyondWordsPlayer",
            path: "BeyondWordsPlayer/BeyondWordsPlayer"
        )
    ]
)
