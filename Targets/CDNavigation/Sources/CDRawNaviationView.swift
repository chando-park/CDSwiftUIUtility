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

public struct CDRawNaviationView<Content: View>: UIViewControllerRepresentable {
    
    @Binding var statusBarColor: Color
    @Binding var navigationBarBackgroundType: ConvertedNavigationController.NavigationBarBackgroundType
    @Binding var navigationBarTitleType: ConvertedNavigationController.NavigationBarTitleType
    @Binding var closeImage: UIImage?
    @Binding var backImage: UIImage?
    @Binding var isNavigationBarHidden: Bool
    @Binding var isBackBtnHidden: Bool
    @Binding var isCloseBtnHidden: Bool
    
    var topInset: CGFloat
    
    var content: () -> Content
    
    var callback: (UINavigationController, UIViewController) -> Void
    
    
    public init(statusBarColor: Binding<Color>,
                navigationBarBackgroundType: Binding<ConvertedNavigationController.NavigationBarBackgroundType>,
                navigationBarTitleType: Binding<ConvertedNavigationController.NavigationBarTitleType>,
                closeImage: Binding<UIImage?>,
                backImage: Binding<UIImage?>,
                isNavigationBarHidden: Binding<Bool>,
                isBackBtnHidden: Binding<Bool>,
                isCloseBtnHidden: Binding<Bool>,
                topInset: CGFloat, // topInset 추가
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
        self.topInset = topInset // topInset 초기화
        self.content = content // content 초기화
        self.callback = callback
    }
    
    public func makeUIViewController(context: Context) -> ConvertedNavigationController {
        
        let root = content()
            .isNViewBackButtonHidden(true)
            .nViewTitle(self.navigationBarTitleType)
            .nViewStatusBarColor(self.statusBarColor)
            .nViewIsNaviBarHidden(self.isNavigationBarHidden)
            .nViewIsCloseButtonHidden(self.isCloseBtnHidden)
//            .ignoresSafeArea([.container])
        let navigationController = ConvertedNavigationController(topInset: topInset,
                                                                 navigationBarBackgroundType: navigationBarBackgroundType,
                                                                 navigationBarTitleType: navigationBarTitleType,
                                                                 statusBarColor: UIColor(statusBarColor),
                                                                 closeImage: closeImage,
                                                                 backImage: backImage,
                                                                 rootViewController: UIHostingController(rootView: root))
        navigationController.delegate = context.coordinator
        return navigationController
    }
    
    public func updateUIViewController(_ uiViewController: ConvertedNavigationController, context: Context) {

        uiViewController.setStatusBar(color: UIColor(self.statusBarColor))
        uiViewController.isNaviBarHidden = self.isNavigationBarHidden
        uiViewController.isBackBtnHidden = self.isBackBtnHidden
        uiViewController.isCloseBtnHidden = self.isCloseBtnHidden
        uiViewController.navigationBarTitleType = self.navigationBarTitleType
        
    }
    
    public func makeCoordinator() -> NavigationSlave {
        NavigationSlave(owner: self)
    }
    
    
    public class NavigationSlave: NSObject, UINavigationControllerDelegate{
        
        var owner: CDRawNaviationView
        
        public init(owner: CDRawNaviationView) {
            self.owner = owner
        }
        
        public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
            self.owner.callback(navigationController, viewController)
            print("Mirror(reflecting: self).subjectType \(Mirror(reflecting: self.owner).subjectType)")
            print("viewController \(viewController)")

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
