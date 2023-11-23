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

public struct CDNavigationWrapper<Content: View>: UIViewControllerRepresentable{

    @ObservedObject var config: CDNavigationConfiguration
    var content: () -> Content
    
    public init(config: CDNavigationConfiguration, content: @escaping () -> Content) {
        self.config = config
        self.content = content
    }

    public func makeUIViewController(context: Context) -> CDNavigationController {
        let root = content()

        let nc = CDNavigationController(navigationBarHeight: self.config.navigationBarHeight,
                                        navigationBarBackgroundType: self.config.navigationBarBackgroundType,
                                        navigationBarTitleType: self.config.navigationBarTitleType,
                                        statusBarColor: self.config.statusBarColor,
                                        closeImage: self.config.closeImage,
                                        backImage: self.config.backImage,
                                        rootViewController: UIHostingController(rootView: root))
        nc.delegate = context.coordinator
        return nc
    }
    
    public func updateUIViewController(_ uiViewController: CDNavigationController, context: Context) {
        
        uiViewController.statusBarColor = self.config.statusBarColor
        uiViewController.navigationBarBackgroundType = self.config.navigationBarBackgroundType
        uiViewController.navigationBarTitleType = self.config.navigationBarTitleType
        
        if let image = self.config.backImage{
            uiViewController.backImage = image
        }
        if let image = self.config.closeImage{
            uiViewController.closeImage = image
        }

        uiViewController.isBackBtnHidden = self.config.isBackBtnHidden
        uiViewController.isCloseBtnHidden = self.config.isCloseBtnHidden
        uiViewController.isNaviBarHidden = self.config.isNavigationBarHidden
        
        uiViewController.setBackEvent(event: self.config.backEvent)
        uiViewController.setCloseEvent(event: self.config.closeEvent)
        uiViewController.action = self.config.action
    }
    
    public func makeCoordinator() -> NavigationSlave {
        NavigationSlave(owner: self)
    }
    
    public class NavigationSlave: NSObject, UINavigationControllerDelegate{
        
        var owner: CDNavigationWrapper
        
        public init(owner: CDNavigationWrapper) {
            self.owner = owner
        }
        
        public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
//            self.owner.callback(navigationController, viewController)
        }
        
    }
}
