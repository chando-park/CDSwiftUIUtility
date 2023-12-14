//
//  CDRoutingView.swift
//  CDUtilityTestAppSwiftUI
//
//  Created by Littlefox iOS Developer on 2023/08/17.
//

import SwiftUI
import CDSheetRouter

extension View {
    func prefersHomeIndicatorAutoHidden() -> some View {
        background(HiddenHomeIndicatorHostingController())
    }
}

struct HiddenHomeIndicatorHostingController: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController

    func makeUIViewController(context: Context) -> UIViewController {
        HiddenHomeIndicatorViewController(rootView: AnyView(EmptyView()))
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

final class HiddenHomeIndicatorViewController: UIHostingController<AnyView> {
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
}

enum SheetRouter: SheetRouterProtocol {
    case fullsheet
    case frontsheet
    case pushsheet
    case email
  
    @ViewBuilder func buildView(isSheeted: Binding<Bool>) -> some View {
        switch self {
        case .fullsheet:
            FullScreenView(isSheeted: isSheeted)
        case .pushsheet:
            PushView(isSheeted: isSheeted)
        case .frontsheet:
            FrontView(isSheeted: isSheeted)
        case .email:
            EmailComposeView(to: "", subject: "", message: "", canUseAction: nil)
        }
    }

}

struct CDRoutingView: View {
    
    @StateObject var router =  MovingSheetOperator<SheetRouter>()

    var body: some View {
        List {
            Section {
                Button("full") {
                    router.go(.fullsheet, animation: .full(animationOn: false))
                }
                Button("push") {
                    router.go(.pushsheet, animation: .push)
                }
                Button("front") {
                    router.go(.frontsheet, animation: .front)
                }
                Button("emali") {
                    router.go(.email, animation: .front)
                }
            }
        }
        .routering($router.sheets)
        
    }
}

struct CDRoutingTestingView: View{
    var body: some View {
        NavigationView {
            CDRoutingView()
            .navigationTitle("Sheet Animation")
        }
        .prefersHomeIndicatorAutoHidden()
    }
}

struct CDRoutingView_Previews: PreviewProvider {
    static var previews: some View {
        CDRoutingTestingView()
        
    }
}


struct FullScreenView: View {

    @Binding var isSheeted: Bool
    
    var body: some View {
        VStack {
            Button("Close") {
                isSheeted = false
            }
        }
    }
}


struct PushView: View {
    
    @Binding var isSheeted: Bool
    
    var body: some View {
        List {
            Section {
                Button("Close") {
                    isSheeted = false
                }
            }
        }
        .navigationTitle("Sheet")
    }
}

struct FrontView: View {
    
    @Binding var isSheeted: Bool
    
    var body: some View {
        List {
            Section {
                Button("Close") {
                    isSheeted = false
                }
            }
        }
        .navigationTitle("Sheet")
    }
}

