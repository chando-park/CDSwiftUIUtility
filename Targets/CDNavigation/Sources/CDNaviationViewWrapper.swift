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

public struct CDNavigationView<Content: View>: UIViewControllerRepresentable {

    var config: CDNavigationConfiguration = .shared
    var content: () -> Content
    
    public init(content: @escaping () -> Content) {
        self.content = content
    }

    public func makeUIViewController(context: Context) -> CDNavigationController {
        
        let root = content()
        let navigationController = CDNavigationController(navigationBarHeight: self.config.navigationBarHeight,
                                                          navigationBarBackgroundType: self.config.navigationBarBackgroundType,
                                                          navigationBarTitleType: self.config.navigationBarTitleType,
                                                          statusBarColor: UIColor(self.config.statusBarColor),
                                                          closeImage: self.config.closeImage,
                                                          backImage: self.config.backImage,
                                                          backEvent: self.config.backEvent,
                                                          closeEvent: self.config.closeEvent,
                                                          rootViewController: UIHostingController(rootView: root))
        navigationController.delegate = context.coordinator
        return navigationController
    }
    
    public func updateUIViewController(_ uiViewController: CDNavigationController, context: Context) {
        
        print("self.config : \(self.config.isBackBtnHidden)")
        
        uiViewController.setStatusBar(color: UIColor(self.config.statusBarColor))
        uiViewController.isNaviBarHidden = self.config.isNavigationBarHidden
        uiViewController.isBackBtnHidden = self.config.isBackBtnHidden
        uiViewController.isCloseBtnHidden = self.config.isCloseBtnHidden
        uiViewController.navigationBarTitleType = self.config.navigationBarTitleType
         
        uiViewController.setBackEvent(event: self.config.backEvent)
        uiViewController.action = self.config.action
        
        uiViewController.closeImage = self.config.closeImage
        uiViewController.backImage = self.config.backImage
        
        uiViewController.setBackEvent(event: self.config.backEvent)
        uiViewController.setCloseEvent(event: self.config.closeEvent)
        
        uiViewController.navigationBarBackgroundType = self.config.navigationBarBackgroundType
        
    }
    
    public func makeCoordinator() -> NavigationSlave {
        NavigationSlave(owner: self)
    }
    
    
    public class NavigationSlave: NSObject, UINavigationControllerDelegate{
        
        var owner: CDNavigationView
        
        public init(owner: CDNavigationView) {
            self.owner = owner
        }
        
        public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
//            self.owner.callback(navigationController, viewController)
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

