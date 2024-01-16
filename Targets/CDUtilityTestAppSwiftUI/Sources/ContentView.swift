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
import CoreData

enum AppRouter: SheetRouterProtocol {
    case web
    case router
    case navigation
    case pdf//(url: URL, title: String)
    case sound
    
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
        case .sound:
            SoundView()
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
//            textentity
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
                Button("sound") {
//                    CDOrientationLock.shared.rotate(orientation: .landscape)
                    self.router.go(.sound, animation: .push)
                    
                }
                
               Button("coredata save") {
                   CDCoreDataSinglton.shared.insertNewObject(name: "안녕", age: 65)
                }
                Button("coredata get") {
                    CDCoreDataSinglton.shared.getObject()
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
