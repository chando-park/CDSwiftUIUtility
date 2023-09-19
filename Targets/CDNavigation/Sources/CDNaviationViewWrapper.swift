//
//  NView.swift
//  Phonics
//
//  Created by Littlefox iOS Developer on 2023/07/24.
//  Copyright © 2023 com.littlefox. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

public struct CDNaviationViewWrapper<Content: View>: UIViewControllerRepresentable {
    
    @Binding var statusBarColor: Color
    @Binding var navigationBarBackgroundType: CDNavigationController.NavigationBarBackgroundType
    @Binding var navigationBarTitleType: CDNavigationController.NavigationBarTitleType
    @Binding var closeImage: UIImage?
    @Binding var backImage: UIImage?
    @Binding var isNavigationBarHidden: Bool
    @Binding var isBackBtnHidden: Bool
    @Binding var isCloseBtnHidden: Bool
    
    @Binding var navigationBarHeight: CGFloat
    
    @Binding var action: CDNavigationController.Action?
    
    var backEvent: CDNavigationController.Event?
    var closeEvent: CDNavigationController.Event?
    var content: () -> Content
    
    var callback: (UINavigationController, UIViewController) -> Void
    
    
    public init(statusBarColor: Binding<Color>,
                navigationBarBackgroundType: Binding<CDNavigationController.NavigationBarBackgroundType>,
                navigationBarTitleType: Binding<CDNavigationController.NavigationBarTitleType>,
                closeImage: Binding<UIImage?>,
                backImage: Binding<UIImage?>,
                isNavigationBarHidden: Binding<Bool>,
                isBackBtnHidden: Binding<Bool>,
                isCloseBtnHidden: Binding<Bool>,
                navigationBarHeight: Binding<CGFloat>, // navigationBarHeight 추가
                action: Binding<CDNavigationController.Action?>, // navigationBarHeight 추가
                backEvent: CDNavigationController.Event?,
                closeEvent: CDNavigationController.Event?,
                content: @escaping () -> Content, // content 추가
                callback: @escaping (UINavigationController, UIViewController) -> Void) {
        _statusBarColor = statusBarColor
        _navigationBarBackgroundType = navigationBarBackgroundType
        _navigationBarTitleType = navigationBarTitleType
        _closeImage = closeImage
        _backImage = backImage
        _isNavigationBarHidden = isNavigationBarHidden
        _isBackBtnHidden = isBackBtnHidden
        _isCloseBtnHidden = isCloseBtnHidden
        _navigationBarHeight = navigationBarHeight
        _action = action
//        self.navigationBarHeight = navigationBarHeight // navigationBarHeight 초기화
        self.content = content // content 초기화
        self.callback = callback
        self.backEvent = backEvent
        self.closeEvent = closeEvent
    }
    
    public func makeUIViewController(context: Context) -> CDNavigationController {
        
        let root = content()
            .nViewTitle(self.navigationBarTitleType.title, subTitle: self.navigationBarTitleType.subTitle)
            .nViewStatusBarColor(self.statusBarColor)
            .nViewIsNaviBarHidden(self.isNavigationBarHidden)
            .nViewCloseButtonImage(self.closeImage)
            .nViewBackButtonImage(self.backImage)
            .nViewIsBackButtonHidden(self.isBackBtnHidden)
            .nViewIsCloseButtonHidden(self.isCloseBtnHidden)
            
        
        let navigationController = CDNavigationController(navigationBarHeight: navigationBarHeight,
                                                          navigationBarBackgroundType: navigationBarBackgroundType,
                                                          navigationBarTitleType: navigationBarTitleType,
                                                          statusBarColor: UIColor(statusBarColor),
                                                          closeImage: closeImage,
                                                          backImage: backImage,
                                                          backEvent: backEvent,
                                                          closeEvent: closeEvent,
                                                          rootViewController: UIHostingController(rootView: root))
        navigationController.delegate = context.coordinator
        return navigationController
    }
    
    public func updateUIViewController(_ uiViewController: CDNavigationController, context: Context) {
        
        uiViewController.setStatusBar(color: UIColor(self.statusBarColor))
        uiViewController.isNaviBarHidden = self.isNavigationBarHidden
        uiViewController.isBackBtnHidden = self.isBackBtnHidden
        uiViewController.isCloseBtnHidden = self.isCloseBtnHidden
        uiViewController.navigationBarTitleType = self.navigationBarTitleType
        
        uiViewController.setBackEvent(event: self.backEvent)
        uiViewController.action = self.action
        
        uiViewController.closeImage = self.closeImage
        uiViewController.backImage = self.backImage
        
    }
    
    public func makeCoordinator() -> NavigationSlave {
        NavigationSlave(owner: self)
    }
    
    
    public class NavigationSlave: NSObject, UINavigationControllerDelegate{
        
        var owner: CDNaviationViewWrapper
        
        public init(owner: CDNaviationViewWrapper) {
            self.owner = owner
        }
        
        public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
            self.owner.callback(navigationController, viewController)
//            print("Mirror(reflecting: self).subjectType \(Mirror(reflecting: self.owner).subjectType)")
//            print("viewController \(viewController)")

        }
    }
}





public extension UIViewController{
    var statusBarHeight : CGFloat {
        if let safeFrame = UIApplication.shared.windows.first?.safeAreaInsets{
            return Swift.max(safeFrame.top, safeFrame.left)
        }
        return 0
    }
}

