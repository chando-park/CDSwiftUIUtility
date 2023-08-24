//
//  CDNavigationView.swift
//  CDNavigation
//
//  Created by Littlefox iOS Developer on 2023/08/24.
//

import SwiftUI

public struct CDNavigationView<Content: View>: View{

    @ObservedObject var config: CDNavigationViewConfiguration
    var content: () -> Content
    
    public var body: some View{
        
        NView(
            statusBarColor: $config.statusBarColor,
            navigationBarBackgroundType:  $config.navigationBarBackgroundType,
            navigationBarTitleType: $config.navigationBarTitleType,
            closeImage:  $config.closeImage,
            backImage:  $config.backImage,
            isNavigationBarHidden:  $config.isNavigationBarHidden,
            isBackBtnHidden:  $config.isBackBtnHidden,
            isCloseBtnHidden:  $config.isCloseBtnHidden,
            topInset: UIScreen.main.bounds.height*(183/2436),content: content,
            callback: { n, c in
//                print("n \(n), c \(c.self)")
                if n.children.count > 1 {
//                    self.isNavigationBarHidden = true
//                    self.isBackBtnHidden = false
                    
                }else{
//                    self.isNavigationBarHidden = false
//                    self.isBackBtnHidden = true
                }
            })
            .onPreferenceChange(NViewBackButtonHiddenPreferenceKey.self) { isHidden in
                print("isHidden \(isHidden)")
                config.isBackBtnHidden = isHidden
            }
            .ignoresSafeArea([.container])
        
    }
}


struct NView_Previews: PreviewProvider {
    static var previews: some View {
        CDNavigationView(config: CDNavigationViewConfiguration(statusBarColor: .green,
                                                               navigationBarBackgroundType: .paint(color: .orange),
                                                               navigationBarTitleType: .text(title: "회원 탈퇴", color: .white),
                                                               closeImage: UIImage(named: Bundle.module.bundlePath + "/home-menu.png"),
                                                               backImage: UIImage(named: Bundle.module.bundlePath + "/pre-menu.png"),
                                                               isNavigationBarHidden: false,
                                                               isBackBtnHidden: true,
                                                               isCloseBtnHidden: false)){
            ZStack{
                Color.yellow
                NavigationLink("new") {
                    SecoundScreenView()
                        .isNViewBackButtonHiddenView(false)
                        .navigationBarBackButtonHidden()
                }
            }
        }
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
