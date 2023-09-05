//
//  CDRoutingView.swift
//  CDUtilityTestAppSwiftUI
//
//  Created by Littlefox iOS Developer on 2023/08/17.
//

import SwiftUI
import CDSheetRouter


enum SheetRouter: SheetRouterProtocol {
    case fullsheet
    case frontsheet
    case pushsheet
  
    @ViewBuilder func buildView(isSheeted: Binding<Bool>) -> some View {
        switch self {
        case .fullsheet:
            FullScreenView(isSheeted: isSheeted)
        case .pushsheet:
            PushView(isSheeted: isSheeted)
        case .frontsheet:
            FrontView(isSheeted: isSheeted)
        }
    }

}

struct TestModel: Hashable{
    var name: String
}

enum MianEventKind: EventKind{
    case login
    case signup
}

class TestVM: PlatformOperatorVM_P{

    func received(event: MianEventKind) {
        switch event {
        case .login:
            break
        case .signup:
            print("signup")
        }
    }
}

struct CDRoutingView: View {
    
    @StateObject var router: PlatformOperator<SheetRouter,TestVM>

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
            }
        }
        .routering($router.sheets)
    }
}

struct CDRoutingTestingView: View{
    var body: some View {
        NavigationView {
            CDRoutingView(router: PlatformOperator<SheetRouter,TestVM>(viewModel: TestVM()))
            .navigationTitle("Sheet Animation")
        }
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

