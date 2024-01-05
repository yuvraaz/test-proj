// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "PocketLabImageProcessing",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "PocketLabImageProcessing",
            targets: ["PocketLabImageProcessing"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/ashleymills/Reachability.swift.git", from: "5.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "PocketLabImageProcessing",
            dependencies: [.product(name: "Reachability", package: "reachability.swift")],
            resources: [
                .process("PackageImages.xcassets"),
//                .process("PackageImages.xcassets"),
//                .process("API/UploadImagesAPI.swift"),
//                .process("Preview Content/SampleRemoteId.json"),
//                .process("Preview Content/ScenarioResponse.json"),
//                .process("Preview Content/Sample.json"),
//                .process("Preview Content/PastAction.json"),
//                .process("Preview Content/Acquisition.json"),
//                .process("Preview Content/TargetSample.json"),
            ]
        ),
        .testTarget(
            name: "PocketLabImageProcessingTests",
            dependencies: ["PocketLabImageProcessing"]),
    ]
)
