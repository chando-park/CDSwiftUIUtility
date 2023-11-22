//
//  ContentView.swift
//  CDUtiltyTestAppSwiftUI
//
//  Created by Littlefox iOS Developer on 2023/08/02.
//

import SwiftUI
import CDWeb
import CDSheetRouter
import CDDocumentViewer
import CDFileDownLoader
import CDActivityView
import CDOrientation

enum AppRouter: SheetRouterProtocol {
    case web
    case router
    case navigation
    case pdf//(url: URL, title: String)
    
    var id: String { "\(self)" }
    
    @ViewBuilder func buildView(isSheeted: Binding<Bool>) -> some View {
        switch self {
        case .web:
            WebTestView()
        case .router:
            CDRoutingTestingView()
        case .navigation:
            NavigtionTestView()
        case .pdf:
            CDPDFViewerView()
                
        }
    }

}

enum AppRouterKind{
    case login
    case signup
    case openPDF//(urlStr: String, title: String)
}

class AppRouterVM: ObservableObject{
    func received(event: AppRouterKind) {
        print("evemnt \(event)")
    }
}

struct ContentView: View{
    @StateObject var vm = AppRouterVM()
    @StateObject var router = MovingSheetOperator<AppRouter>()
    
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
//                    CDOrientationLock.shared.rotate(orientation: .landscape)
                    router.go(.navigation, animation: .full(animationOn: true))
                }
                Button("open pdf") {
//                    CDOrientationLock.shared.rotate(orientation: .landscape)
                    self.router.go(.pdf, animation: .push)
                    
                }
            }
        }
        .routering($router.sheets)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        @ObservedObject var vm = AppRouterVM()
//        @ObservedObject var platform = PlatformOperator<AppRouter,AppRouterVM>(viewModel: vm)
        NavigationView {
            ContentView()
        }
    }
}
