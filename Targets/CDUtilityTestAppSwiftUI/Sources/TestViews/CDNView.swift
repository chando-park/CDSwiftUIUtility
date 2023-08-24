//
//  NView.swift
//  CDUtilityTestAppSwiftUI
//
//  Created by Littlefox iOS Developer on 2023/08/23.
//

import SwiftUI
import CDNavigation


struct NavigtionTestView: View{
    @State var statusBarColor: Color = .green
    @State var navigationBarBackgroundType: ConvertedNavigationController.NavigationBarBackgroundType =
        .image(image: UIImage(named: "top-bg-img.png")!)
//        .paint(color: .orange)
    @State var navigationBarTitleType: ConvertedNavigationController.NavigationBarTitleType = .text(title: "aaa", color: .blue)
    @State var closeImage: UIImage? = UIImage(named: "home-menu.png")
    @State var backImage: UIImage? = UIImage(named: "pre-menu.png")
    @State var isNavigationBarHidden: Bool = false
    @State var isBackBtnHidden: Bool = true
    @State var isCloseBtnHidden: Bool = false
    
    var body: some View{
        NView(
            statusBarColor: $statusBarColor,
            navigationBarBackgroundType: $navigationBarBackgroundType,
            navigationBarTitleType: $navigationBarTitleType,
            closeImage: $closeImage,
            backImage: $backImage,
            isNavigationBarHidden: $isNavigationBarHidden,
            isBackBtnHidden: $isBackBtnHidden,
            isCloseBtnHidden: $isCloseBtnHidden,
            topInset: UIScreen.main.bounds.height*(183/2436)) {
                ZStack{
                    Color.yellow
                    NavigationLink("new") {
                        SecoundScreenView()
                            .isNViewBackButtonHiddenView(false)
                            .navigationBarBackButtonHidden()
                    }
                }
            } callback: { n, c in
                print("n \(n), c \(c.self)")
                if n.children.count > 1 {
//                    self.isNavigationBarHidden = true
//                    self.isBackBtnHidden = false
                    
                }else{
//                    self.isNavigationBarHidden = false
//                    self.isBackBtnHidden = true
                }
            }
            .onPreferenceChange(NViewBackButtonHiddenPreferenceKey.self) { isHidden in
                print("isHidden \(isHidden)")
                self.isBackBtnHidden = isHidden
            }
            .ignoresSafeArea([.container])
        
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
        }.ignoresSafeArea([.container])
    }
}
