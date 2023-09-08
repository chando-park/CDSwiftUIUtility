//
//  CDNavigationViewConfiguration.swift
//  CDNavigation
//
//  Created by Littlefox iOS Developer on 2023/08/24.
//

import SwiftUI

public class CDNavigationViewConfiguration: ObservableObject{
    
    @Published var statusBarColor: Color
    @Published var navigationBarBackgroundType: ConvertedNavigationController.NavigationBarBackgroundType
    @Published var navigationBarTitleType: ConvertedNavigationController.NavigationBarTitleType
    @Published var topInset: CGFloat
    @Published var closeImage: UIImage?
    @Published var backImage: UIImage?
    @Published var isNavigationBarHidden: Bool
    @Published var isBackBtnHidden: Bool
    @Published var isCloseBtnHidden: Bool
    
    
    public init(statusBarColor: Color,
                navigationBarBackgroundType: ConvertedNavigationController.NavigationBarBackgroundType,
                navigationBarTitleType: ConvertedNavigationController.NavigationBarTitleType,
                topInset: CGFloat,
                closeImage: UIImage? = nil,
                backImage: UIImage? = nil,
                isNavigationBarHidden: Bool,
                isBackBtnHidden: Bool,
                isCloseBtnHidden: Bool) {
        self.statusBarColor = statusBarColor
        self.navigationBarBackgroundType = navigationBarBackgroundType
        self.navigationBarTitleType = navigationBarTitleType
        self.topInset = topInset
        self.closeImage = closeImage
        self.backImage = backImage
        self.isNavigationBarHidden = isNavigationBarHidden
        self.isBackBtnHidden = isBackBtnHidden
        self.isCloseBtnHidden = isCloseBtnHidden
        
    }
}
