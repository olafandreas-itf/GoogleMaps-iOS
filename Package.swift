// swift-tools-version:5.3
import PackageDescription

let repoHost = "olafandreas-itf"
let repoName = "GoogleMaps-iOS"
let version = "7.1.0"

let checksums: [Framework: String] = [
    .googleMaps: "2716512d8bf2288b2a94b284678d4d4c78d98790efb0b2377b3f3d2416dd5a8c",
    .googleMapsBase: "cbbb6f6cf40d6593c7326edcf63805e36a29591fe3038b1367e7bb452b810e75",
    .googleMapsCore: "33bb8d66ca678765ef7447d7c404bce3eca088c0a7ae2e5b2f6ebbe007e28f50",
    .googleMapsM4B: "a3a24eac0d2164cedc97c36511112c53df89f61dbf16f42e42ffd5b76c825f37"
]

enum Framework: String, CaseIterable {
    case googleMaps = "GoogleMaps"
    case googleMapsBase = "GoogleMapsBase"
    case googleMapsCore = "GoogleMapsCore"
    case googleMapsM4B = "GoogleMapsM4B"
}

func getUrlForFramework(name frameworkName: String) -> String {
    return String(format: "https://github.com/%@/%@/releases/download/%@/%@.xcframework.zip", repoHost, repoName, version, frameworkName)
}

func getBinaryTarget(for framework: Framework) -> Target {
    let name = framework.rawValue
    return Target.binaryTarget(
        name: name,
        url: getUrlForFramework(name: name),
        checksum: checksums[framework]!
    )
}

let package = Package(
    name: repoName,
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: repoName,
            targets: Framework.allCases.map({ $0.rawValue }))
    ],
    targets: [
        getBinaryTarget(for: .googleMaps),
        getBinaryTarget(for: .googleMapsBase),
        getBinaryTarget(for: .googleMapsCore),
        getBinaryTarget(for: .googleMapsM4B),
    ]
)