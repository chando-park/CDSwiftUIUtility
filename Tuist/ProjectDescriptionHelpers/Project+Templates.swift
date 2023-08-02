import ProjectDescription

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/

extension Project {
    /// Helper function to create the Project for this ExampleApp
    public static func app(name: String, targetsNames:[String]) -> Project {
        var targets = makeFrameworkTargets(targetsNames: targetsNames)
        
        return Project(
            name: name,
            targets: targets
        )
    }

    // MARK: - Private
    private static func makeFrameworkTargets(targetsNames:[String]) -> [Target] {

        var targets = [Target]()
        for name in targetsNames{
            let sources = Target(name: name,
                                 platform: .iOS,
                                 product: .framework,
                                 bundleId: "com.tao.\(name)",
                                 infoPlist: .default,
                                 sources: ["Targets/\(name)/Sources/**"],
                                 resources: ["Targets/\(name)/Resources/**"],
                                 dependencies: [])
            let tests = Target(name: "\(name)Tests",
                               platform: .iOS,
                               product: .unitTests,
                               bundleId: "com.tao.\(name)Tests",
                               infoPlist: .default,
                               sources: ["Targets/\(name)/Tests/**"],
                               resources: [],
                               dependencies: [.target(name: name)])
            
            targets.append(sources)
            targets.append(tests)
        }
        
        
        return targets
    }
//
//    /// Helper function to create the application target and the unit test target.
//    private static func makeAppTargets(name: String, platform: Platform, dependencies: [TargetDependency]) -> [Target] {
//        let platform: Platform = platform
//        let infoPlist: [String: InfoPlist.Value] = [
//            "CFBundleShortVersionString": "1.0",
//            "CFBundleVersion": "1",
//            "UIMainStoryboardFile": "",
//            "UILaunchStoryboardName": "LaunchScreen"
//            ]
//
//        let mainTarget = Target(
//            name: name,
//            platform: platform,
//            product: .app,
//            bundleId: "io.tuist.\(name)",
//            infoPlist: .extendingDefault(with: infoPlist),
//            sources: ["Targets/\(name)/Sources/**"],
//            resources: ["Targets/\(name)/Resources/**"],
//            dependencies: dependencies
//        )
//
//        let testTarget = Target(
//            name: "\(name)Tests",
//            platform: platform,
//            product: .unitTests,
//            bundleId: "io.tuist.\(name)Tests",
//            infoPlist: .default,
//            sources: ["Targets/\(name)/Tests/**"],
//            dependencies: [
//                .target(name: "\(name)")
//        ])
//        return [mainTarget, testTarget]
//    }
}
