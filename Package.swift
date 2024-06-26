// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CDUtility",
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15)//, tvOS(.v13), watchOS(.v6) 등의 플랫폼 버전을 지정합니다.
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "CDWeb",
            targets: ["CDWeb"]),
        .library(
            name: "CDSheetRouter",
            targets: ["CDSheetRouter"]),
        .library(
            name: "CDNavigation",
            targets: ["CDNavigation"]),
        .library(
            name: "CDDocumentViewer",
            targets: ["CDDocumentViewer"]),
        .library(
            name: "CDFileDownLoader",
            targets: ["CDFileDownLoader"]),
        .library(
            name: "CDActivityView",
            targets: ["CDActivityView"]),
        .library(
            name: "CDOrientation",
            targets: ["CDOrientation"]),
        .library(
            name: "CDSound",
            targets: ["CDSound"]),
        .library(
            name: "CDNetworkCheck",
            targets: ["CDNetworkCheck"]),
        .library(
            name: "CDCoreDataStack",
            targets: ["CDCoreDataStack"]),
        .library(
            name: "CDURLSessionPublisher",
            targets: ["CDURLSessionPublisher"]),
    ],
    
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "CDWeb",
            dependencies: [],
            path: "Targets/CDWeb/Sources"),
        
            .testTarget(
                name: "CDWebTests",
                dependencies: ["CDWeb"],
                path: "Targets/CDWeb/Tests"),
        
            .target(
                name: "CDSheetRouter",
                dependencies: ["CDDocumentViewer"],
                path: "Targets/CDSheetRouter/Sources"),
        
            .testTarget(
                name: "CDSheetRouterTests",
                dependencies: ["CDSheetRouter"],
                path: "Targets/CDSheetRouter/Tests"),
        
            .target(
                name: "CDNavigation",
                dependencies: [],
                path: "Targets/CDNavigation/Sources"),
        
            .testTarget(
                name: "CDNavigationTests",
                dependencies: ["CDNavigation"],
                path: "Targets/CDNavigation/Tests"),
        
            .target(
                name: "CDDocumentViewer",
                dependencies: ["CDFileDownLoader", "CDActivityView"],
                path: "Targets/CDDocumentViewer/Sources"),
        
            .target(
                name: "CDFileDownLoader",
                dependencies: [],
                path: "Targets/CDFileDownLoader/Sources"),
        
            .target(
                name: "CDActivityView",
                dependencies: [],
                path: "Targets/CDActivityView/Sources"),
        .target(
            name: "CDOrientation",
            dependencies: [],
            path: "Targets/CDOrientation/Sources"),
        .target(
            name: "CDSound",
            dependencies: [],
            path: "Targets/CDSound/Sources"),
        .target(
            name: "CDNetworkCheck",
            dependencies: [],
            path: "Targets/CDNetworkCheck/Sources"),
        .target(
            name: "CDCoreDataStack",
            dependencies: [],
            path: "Targets/CDCoreDataStack/Sources"),
        .target(
            name: "CDURLSessionPublisher",
            dependencies: [],
            path: "Targets/CDURLSessionPublisher/Sources"),
        
    ]
)
