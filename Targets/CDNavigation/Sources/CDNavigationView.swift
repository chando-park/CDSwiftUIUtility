//
//  CDNavigationView.swift
//  CDNavigation
//
//  Created by Littlefox iOS Developer on 2023/08/24.
//

import SwiftUI


//public class CDNavigationConfiguration: ObservableObject{
//    
//    deinit{
//        print("deitit \(self)")
//    }
//    
//    @Published public var statusBarColor: Color
//    @Published public var navigationBarBackgroundType: CDNavigationController.NavigationBarBackgroundType
//    @Published public var navigationBarTitleType: CDNavigationController.NavigationBarTitleType
//    @Published public var navigationBarHeight: CGFloat
//    @Published public var closeImage: UIImage?
//    @Published public var backImage: UIImage?
//    @Published public var isNavigationBarHidden: Bool
//    @Published public var isBackBtnHidden: Bool
//    @Published public var isCloseBtnHidden: Bool
//    @Published public var action: CDNavigationController.Action?
//    @Published public var isUsePreference: Bool
//    
//    public var backEvent: CDNavigationController.Event?
//    public var closeEvent: CDNavigationController.Event?
//    
//    public init(statusBarColor: Color,
//                navigationBarBackgroundType: CDNavigationController.NavigationBarBackgroundType,
//                navigationBarTitleType: CDNavigationController.NavigationBarTitleType,
//                navigationBarHeight: CGFloat,
//                closeImage: UIImage? = nil,
//                backImage: UIImage? = nil,
//                isNavigationBarHidden: Bool,
//                isBackBtnHidden: Bool,
//                isCloseBtnHidden: Bool,
//                action: CDNavigationController.Action? = nil,
//                isUsePreference: Bool,
//                backEvent: CDNavigationController.Event? = nil,
//                closeEvent: CDNavigationController.Event? = nil) {
//        self.statusBarColor = statusBarColor
//        self.navigationBarBackgroundType = navigationBarBackgroundType
//        self.navigationBarTitleType = navigationBarTitleType
//        self.navigationBarHeight = navigationBarHeight
//        self.closeImage = closeImage
//        self.backImage = backImage
//        self.isNavigationBarHidden = isNavigationBarHidden
//        self.isBackBtnHidden = isBackBtnHidden
//        self.isCloseBtnHidden = isCloseBtnHidden
//        self.action = action
//        self.isUsePreference = isUsePreference
//        self.backEvent = backEvent
//        self.closeEvent = closeEvent
//    }
//}

//public struct CDNavigationView<Content: View>: View{
//
//    @ObservedObject public var config: CDNavigationConfiguration = .shared
//    public var content: () -> Content
//    
//    
//    public init(content: @escaping () -> Content) {
//        self.content = content
//    }
//    public var body: some View{
//        CDNaviationViewWrapper(config: config, content: content, callback: { n, c in
//            
//        })
//        .ignoresSafeArea([.container])
//        
//    }
//}
