//
//  MHNavigationConfiguration.swift
//  CDNavigation
//
//  Created by Littlefox iOS Developer on 11/21/23.
//

import SwiftUI

public class CDNavigationConfiguration: ObservableObject{
    
    deinit{
        print("deitit \(self)")
    }
    
    @Published public var statusBarColor: Color
    @Published public var navigationBarBackgroundType: CDNavigationController.NavigationBarBackgroundType
    @Published public var navigationBarTitleType: CDNavigationController.NavigationBarTitleType
    @Published public var navigationBarHeight: CGFloat
    @Published public var closeImage: UIImage?
    @Published public var backImage: UIImage?
    @Published public var isNavigationBarHidden: Bool
    @Published public var isBackBtnHidden: Bool
    @Published public var isCloseBtnHidden: Bool
    @Published public var action: CDNavigationController.Action?
    
    public var titles: (title: String, subTitle: String?) = ("", nil){
        didSet{
            self.navigationBarTitleType = .text(title: self.titles.title, 
                                                subTitle: self.titles.subTitle,
                                                color: self.navigationBarTitleType.color,
                                                font: self.navigationBarTitleType.fontInfo,
                                                subTitleFont: self.navigationBarTitleType.subFontInfo)
        }
    }
    
    public var backEvent: CDNavigationController.Event?
    public var closeEvent: CDNavigationController.Event?
    
    public init(statusBarColor: Color,
                navigationBarBackgroundType: CDNavigationController.NavigationBarBackgroundType,
                navigationBarTitleType: CDNavigationController.NavigationBarTitleType,
                navigationBarHeight: CGFloat,
                closeImage: UIImage?,
                backImage: UIImage?,
                isNavigationBarHidden: Bool,
                isBackBtnHidden: Bool,
                isCloseBtnHidden: Bool,
                action: CDNavigationController.Action? = nil,
                isUsePreference: Bool,
                backEvent: CDNavigationController.Event? = nil,
                closeEvent: CDNavigationController.Event? = nil) {
        self.statusBarColor = statusBarColor
        self.navigationBarBackgroundType = navigationBarBackgroundType
        self.navigationBarTitleType = navigationBarTitleType
        self.navigationBarHeight = navigationBarHeight
        self.closeImage = closeImage
        self.backImage = backImage
        self.isNavigationBarHidden = isNavigationBarHidden
        self.isBackBtnHidden = isBackBtnHidden
        self.isCloseBtnHidden = isCloseBtnHidden
        self.action = action
        self.backEvent = backEvent
        self.closeEvent = closeEvent
    }
}


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
                                        statusBarColor: UIColor(cgColor: self.config.statusBarColor.cgColor!),
                                        closeImage: self.config.closeImage,
                                        backImage: self.config.backImage,
                                        rootViewController: UIHostingController(rootView: root))
        nc.delegate = context.coordinator
        return nc
    }
    
    public func updateUIViewController(_ uiViewController: CDNavigationController, context: Context) {
        
        uiViewController.statusBarColor = UIColor(cgColor: self.config.statusBarColor.cgColor!)
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


public struct MHNavigation<Content: View>: View{

    @ObservedObject public var config: CDNavigationConfiguration
    public var content: () -> Content

    public init(config: CDNavigationConfiguration, content: @escaping () -> Content) {
        self.config = config
        self.content = content
    }
    
    public var body: some View{
        CDNavigationWrapper(config: config, content: content)
            .ignoresSafeArea([.container])
        
    }
}
