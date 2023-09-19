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

enum AppRouter: SheetRouterProtocol {
    case web
    case router
    case navigation
    case activity(Binding<[CDActivityType]>)//(url: URL, title: String)
    
    var id: String { "\(self)" }
    
    @ViewBuilder func buildView(isSheeted: Binding<Bool>) -> some View {
        switch self {
        case .web:
            WebTestView()
        case .router:
            CDRoutingTestingView()
        case .navigation:
            NavigtionTestView()
        case .activity(let activities)://(let url, let title):
//            CDPDFViewerView(isShowPreview: isSheeted)
            CDActivityView(activityItmes: activities)
        }
    }

}

enum AppRouterKind: EventKind{
    case login
    case signup
    case openPDF//(urlStr: String, title: String)
}

class AppRouterVM: PlatformOperatorVM_P{
    func received(event: AppRouterKind) {
        print("evemnt \(event)")
    }
}

struct ContentView: View{
    @ObservedObject var vm: AppRouterVM
    @ObservedObject var router:PlatformOperator<AppRouter,AppRouterVM>
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
                Button("pdf") {
                    //.constant([.image(UIImage(named: "pre-menu.png")!)]
                    router.go(.activity(.constant([.image(UIImage(named: "pre-menu.png")!)])), animation: .front(.medium))
                }
            }
        }
        .routering($router.sheets) { router in
            print("rrr \(router)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = AppRouterVM()
        let platform = PlatformOperator<AppRouter,AppRouterVM>(viewModel: vm)
        NavigationView {
            ContentView(vm: vm, router: platform)
        }
    }
}
