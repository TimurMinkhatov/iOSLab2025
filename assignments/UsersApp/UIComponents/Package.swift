// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "UIComponents",
  platforms: [.iOS(.v17)],
  products: [
    .library(name: "UIComponents", targets: ["UIComponents"])
  ],
  dependencies: [
    .package(url: "https://github.com/onevcat/Kingfisher", from: "8.0.0")
  ],
  targets: [
    .target(
      name: "UIComponents",
      dependencies: ["Kingfisher"])
  ])
