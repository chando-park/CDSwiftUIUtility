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
    
    var id: String { "\(self)" }
    
    @ViewBuilder func buildView(isSheeted: Binding<Bool>) -> some View {
        switch self {
        case .web:
            WebTestView()
        case .router:
            CDRoutingTestingView()
        }
    }

}

struct ContentView: View{
    
    @StateObject var router =  SheetRouterOperator<AppRouter>()
    
    var body: some View {
        List {
            Section {
                Button("web") {
                    router.go(.web, animation: .push)
                }
                Button("router") {
                    router.go(.router, animation: .push)
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
