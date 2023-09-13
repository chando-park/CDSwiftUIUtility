//
//  CDNavigationView.swift
//  CDNavigation
//
//  Created by Littlefox iOS Developer on 2023/08/24.
//

import SwiftUI

public struct CDNavigationView<Content: View>: View{

    @ObservedObject var config: CDNavigationViewConfiguration
    var content: () -> Content
    
    public init(config: CDNavigationViewConfiguration, content: @escaping () -> Content) {
        self.config = config
        self.content = content
    }
    
    public var body: some View{
        
        CDRawNaviationView(
            statusBarColor: $config.statusBarColor,
            navigationBarBackgroundType:  $config.navigationBarBackgroundType,
            navigationBarTitleType: $config.navigationBarTitleType,
            closeImage:  $config.closeImage,
            backImage:  $config.backImage,
            isNavigationBarHidden:  $config.isNavigationBarHidden,
            isBackBtnHidden:  $config.isBackBtnHidden,
            isCloseBtnHidden:  $config.isCloseBtnHidden,
            navigationBarHeight: $config.navigationBarHeight,//UIScreen.main.bounds.height*(183/2436),
            content: content,
            callback: { n, c in
            })
            .onPreferenceChange(NViewBackButtonHiddenPreferenceKey.self) { isHidden in
                config.isBackBtnHidden = isHidden
            }
            .onPreferenceChange(NViewTitlePreferenceKey.self) { title in
                let font = config.navigationBarTitleType.fontInfo
                let subFont = config.navigationBarTitleType.subFontInfo
                let color = config.navigationBarTitleType.color
                config.navigationBarTitleType = ConvertedNavigationController.NavigationBarTitleType.text(title: title.title,
                                                                                                          subTitle: title.subTitle,
                                                                                                          color: color,
                                                                                                          font: font,
                                                                                                          subTitleFont: subFont)
            }
            .onPreferenceChange(NViewStatusBarColorPreferenceKey.self) { color in
                config.statusBarColor = color
                
            }
            .onPreferenceChange(NViewBarHiddenPreferenceKey.self) { isHidden in
                config.isNavigationBarHidden = isHidden
                
            }
            .onPreferenceChange(NViewCloseButtonHiddenPreferenceKey.self) { isHidden in
                config.isCloseBtnHidden = isHidden
                
            }
            .ignoresSafeArea([.container])
        
    }
}
