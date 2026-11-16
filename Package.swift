// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "DocumentosBR",
    products: [
        .library(name: "DocumentosBR", targets: ["DocumentosBR"])
    ],
    targets: [
        .target(name: "DocumentosBR"),
        .testTarget(name: "DocumentosBRTests", dependencies: ["DocumentosBR"])
    ]
)