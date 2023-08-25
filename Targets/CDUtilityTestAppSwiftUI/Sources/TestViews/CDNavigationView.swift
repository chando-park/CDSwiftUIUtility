//
//  NView.swift
//  CDUtilityTestAppSwiftUI
//
//  Created by Littlefox iOS Developer on 2023/08/23.
//

import SwiftUI
import CDNavigation

struct NavigtionTestView: View{
    var body: some View{
        CDNavigationView(config: CDNavigationViewConfiguration(statusBarColor: .green,
                                                               navigationBarBackgroundType: .paint(color: .orange),
                                                               navigationBarTitleType: .text(title: "회원 탈퇴", color: .white),
                                                               closeImage: UIImage(named: "home-menu.png"),
                                                               backImage: UIImage(named: "pre-menu.png"),
                                                               isNavigationBarHidden: false,
                                                               isBackBtnHidden: true,
                                                               isCloseBtnHidden: false)){
            ZStack{
                Color.yellow
                NavigationLink("new") {
                    SecoundScreenView()
                        .nViewTitle(.text(title: "회원 가입", color: .black))
                        .isNViewBackButtonHidden(false)
                        .nViewStatusBarColor(.purple)
                        .nViewIsNaviBarHidden()
                        .nViewIsCloseButtonHidden()
                        .navigationBarBackButtonHidden()
                }
            }
        }
    }
}

struct NView_Previews: PreviewProvider {
    static var previews: some View {
        NavigtionTestView()
    }
}



struct SecoundScreenView: View {

    var body: some View {
        VStack(spacing: 0){
            Color.black
            Color.gray
        }
        .onAppear(perform: {
//            print("Mirror(reflecting: self).subjectType \(Mirror(reflecting: self).subjectType)")
        })
        .ignoresSafeArea([.container])
    }
}
