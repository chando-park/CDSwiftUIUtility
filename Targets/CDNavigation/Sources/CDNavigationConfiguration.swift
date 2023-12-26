//
//  MHNavigationConfiguration.swift
//  CDNavigation
//
//  Created by Littlefox iOS Developer on 11/21/23.
//

import SwiftUI

public protocol CDNavigationConfiguration_P: ObservableObject{
    var action: CDNavigationController.Action? {get set}
}

public class CDNavigationConfiguration: CDNavigationConfiguration_P, ObservableObject{
    
    static public let `default`: CDNavigationConfiguration = CDNavigationConfiguration(statusBarColor: .red, 
                                                                                       isStatusHidden: false,
                                                                                       navigationBarBackgroundType: .paint(color: .blue),
                                                                                       navigationBarTitleType: .text(title: "default", subTitle: nil, color: .white, font: .init(size: 10), subTitleFont: nil),
                                                                                       navigationBarHeight: 55,
                                                                                       closeImage: UIImage(systemName: "star.fill"),
                                                                                       backImage: UIImage(systemName: "star.fill"),
                                                                                       isNavigationBarHidden: false,
                                                                                       isBackBtnHidden: false,
                                                                                       isCloseBtnHidden: false)
    
    deinit{
        print("deitit \(self)")
    }
    
    @Published public var statusBarColor: UIColor
    @Published public var isStatusHidden: Bool
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
    
    var backEvent: CDNavigationController.Event?
    var closeEvent: CDNavigationController.Event?
    
    public init(statusBarColor: UIColor,
                isStatusHidden: Bool,
                navigationBarBackgroundType: CDNavigationController.NavigationBarBackgroundType,
                navigationBarTitleType: CDNavigationController.NavigationBarTitleType,
                navigationBarHeight: CGFloat,
                closeImage: UIImage?,
                backImage: UIImage?,
                isNavigationBarHidden: Bool,
                isBackBtnHidden: Bool,
                isCloseBtnHidden: Bool,
                action: CDNavigationController.Action? = nil,
                backEvent: CDNavigationController.Event? = nil,
                closeEvent: CDNavigationController.Event? = nil) {
        self.statusBarColor = statusBarColor
        self.isStatusHidden = isStatusHidden
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
    
    public func setBackEvent(event: CDNavigationController.Event?){
        self.backEvent = event
    }
    
    public func setCloseEvent(event: CDNavigationController.Event?){
        self.closeEvent = event
    }
}
