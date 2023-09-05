//
//  ContentView.swift
//  CDUtiltyTestAppSwiftUI
//
//  Created by Littlefox iOS Developer on 2023/08/02.
//

import SwiftUI
import CDWeb
import CDSheetRouter


enum AppRouter: SheetRouterProtocol {
    case web
    case router
    case navigation
    
    var id: String { "\(self)" }
    
    @ViewBuilder func buildView(isSheeted: Binding<Bool>) -> some View {
        switch self {
        case .web:
            WebTestView()
        case .router:
            CDRoutingTestingView()
        case .navigation:
            NavigtionTestView()
        }
    }

}

enum AppRouterKind: EventKind{
    case login
    case signup
}

class AppRouterVM: PlatformOperatorVM_P{
    func received(event: AppRouterKind) {
        
    }
}

struct ContentView: View{
    
    @StateObject var router =  PlatformOperator<AppRouter,AppRouterVM>(viewModel: AppRouterVM())
    
    var body: some View {
        List {
            Section {
                Button("web") {
                    router.go(.web, animation: .push)
                }
                Button("router") {
                    router.go(.router, animation: .push)
                }
                Button("navigation") {
                    router.go(.navigation, animation: .full(animationOn: true))
                }
                
            }
        }
        .routering($router.sheets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
