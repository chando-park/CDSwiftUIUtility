//
//  CDNavigationViewConfiguration.swift
//  CDNavigation
//
//  Created by Littlefox iOS Developer on 2023/08/24.
//

import SwiftUI

public class CDNavigationViewConfiguration: ObservableObject{
    
    @Published var statusBarColor: Color
    @Published var navigationBarBackgroundType: CDNavigationController.NavigationBarBackgroundType
    @Published var navigationBarTitleType: CDNavigationController.NavigationBarTitleType
    @Published var navigationBarHeight: CGFloat
    @Published var closeImage: UIImage?
    @Published var backImage: UIImage?
    @Published var isNavigationBarHidden: Bool
    @Published var isBackBtnHidden: Bool
    @Published var isCloseBtnHidden: Bool
    
    
    public init(statusBarColor: Color,
                navigationBarBackgroundType: CDNavigationController.NavigationBarBackgroundType,
                navigationBarTitleType: CDNavigationController.NavigationBarTitleType,
                navigationBarHeight: CGFloat,
                closeImage: UIImage? = nil,
                backImage: UIImage? = nil,
                isNavigationBarHidden: Bool,
                isBackBtnHidden: Bool,
                isCloseBtnHidden: Bool) {
        self.statusBarColor = statusBarColor
        self.navigationBarBackgroundType = navigationBarBackgroundType
        self.navigationBarTitleType = navigationBarTitleType
        self.navigationBarHeight = navigationBarHeight
        self.closeImage = closeImage
        self.backImage = backImage
        self.isNavigationBarHidden = isNavigationBarHidden
        self.isBackBtnHidden = isBackBtnHidden
        self.isCloseBtnHidden = isCloseBtnHidden
        
    }
}
