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
    
    public init(config: CDNavigationViewConfiguration, content: @escaping () -> Content) {
        self.config = config
        self.content = content
    }
    
    public var body: some View{
        
        CDRawNaviationView(
            statusBarColor: $config.statusBarColor,
            navigationBarBackgroundType:  $config.navigationBarBackgroundType,
            navigationBarTitleType: $config.navigationBarTitleType,
            closeImage:  $config.closeImage,
            backImage:  $config.backImage,
            isNavigationBarHidden:  $config.isNavigationBarHidden,
            isBackBtnHidden:  $config.isBackBtnHidden,
            isCloseBtnHidden:  $config.isCloseBtnHidden,
            topInset: UIScreen.main.bounds.height*(183/2436),
            content: content,
            callback: { n, c in
            })
            .onPreferenceChange(NViewBackButtonHiddenPreferenceKey.self) { isHidden in
                config.isBackBtnHidden = isHidden
            }
            .onPreferenceChange(NViewTitlePreferenceKey.self) { title in
                if let t = title{
                    config.navigationBarTitleType = t
                }
            }
            .onPreferenceChange(NViewStatusBarColorPreferenceKey.self) { color in
                config.statusBarColor = color
                
            }
            .onPreferenceChange(NViewBarHiddenPreferenceKey.self) { isHidden in
                config.isNavigationBarHidden = isHidden
                
            }
            .onPreferenceChange(NViewCloseButtonHiddenPreferenceKey.self) { isHidden in
                config.isCloseBtnHidden = isHidden
                
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



struct SecoundScreenView: View {

    @State private var items = Array(1...20) // 초기 데이터
    
    var body: some View {
        List(items, id: \.self) { item in
            Text("Item \(item)")
                .onAppear {
                    if item == items.last {
                        // 리스트의 마지막 아이템이 나타나면 새로운 데이터를 추가
//                        loadMoreData()//
                        print("isLast")
                    }
                }
        }
        .ignoresSafeArea([.container])
//        .edgesIgnoringSafeArea([.top])
    }
}
