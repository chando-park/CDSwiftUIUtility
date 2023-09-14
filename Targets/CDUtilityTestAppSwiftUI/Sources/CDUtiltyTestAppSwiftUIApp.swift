//
//  CDUtiltyTestAppSwiftUIApp.swift
//  CDUtiltyTestAppSwiftUI
//
//  Created by Littlefox iOS Developer on 2023/08/02.
//

import SwiftUI
import CDSheetRouter

@main
struct CDUtiltyTestAppSwiftUIApp: App {
    
    let vm = AppRouterVM()
    
    var body: some Scene {        
        WindowGroup {
            NavigationView {
                ContentView(vm: vm, router: PlatformOperator<AppRouter,AppRouterVM>(viewModel: vm))
            }
            
        }
    }
}
