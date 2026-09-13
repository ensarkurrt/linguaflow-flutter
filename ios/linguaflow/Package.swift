// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "linguaflow",
  platforms: [.iOS("13.0")],
  products: [
    .library(name: "linguaflow", targets: ["linguaflow"])
  ],
  dependencies: [
    .package(name: "FlutterFramework", path: "../FlutterFramework")
  ],
  targets: [
    .target(
      name: "linguaflow",
      dependencies: [
        .product(name: "FlutterFramework", package: "FlutterFramework")
      ],
      resources: [.process("PrivacyInfo.xcprivacy")]
    )
  ]
)
