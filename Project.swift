import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

/*
                +-------------+
                |             |
                |     App     | Contains CDUtility App target and CDUtility unit-test target
                |             |
         +------+-------------+-------+
         |         depends on         |
         |                            |
 +----v-----+                   +-----v-----+
 |          |                   |           |
 |   Kit    |                   |     UI    |   Two independent frameworks to share code and start modularising your app
 |          |                   |           |
 +----------+                   +-----------+

 */

// MARK: - Project

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

// Creates our project using a helper function defined in ProjectDescriptionHelpers CDUtility
let project = Project.app(name: "CDUtility",
                          frameworkTargetsNames: [
                            "CDWeb",
                            "CDURLSessionPublisher",
                            "CDSheetRouter",
                            "CDNavigation",
                            "CDActivityView",
                            "CDFileDownLoader",
                            "CDDocumentViewer",
                            "CDOrientation",
                            "CDSound",
                            "CDNetworkCheck",
                            "CDCoreDataStack",
                          ])
