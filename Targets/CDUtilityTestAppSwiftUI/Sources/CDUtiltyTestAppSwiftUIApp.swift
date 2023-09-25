//
//  CDUtiltyTestAppSwiftUIApp.swift
//  CDUtiltyTestAppSwiftUI
//
//  Created by Littlefox iOS Developer on 2023/08/02.
//

import SwiftUI
import CDSheetRouter
import CDNavigation
import CDWeb
import CDOrientation

@main
struct CDUtiltyTestAppSwiftUIApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate: AppDelegate

    @ObservedObject var vm = AppRouterVM()
    @ObservedObject var platform = PlatformOperator<AppRouter,AppRouterVM>(viewModel: AppRouterVM())
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(vm: vm, router: platform)
                    .routering($platform.sheets) { router in
                        print("rrr \(router)")
                    }
            }

        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        print("CDOrientationLock.mask \(CDOrientationLock.shared.currentMask == .portrait)")
        return CDOrientationLock.shared.currentMask
    }
}
