//
//  CDNavigationView.swift
//  CDNavigation
//
//  Created by Littlefox iOS Developer on 2023/08/24.
//

import SwiftUI

public struct CDNavigationView<Content: View>: View{

    @ObservedObject var config: CDNavigationViewConfiguration
    var backEvent: CDNavigationController.Event?
    var closeEvent: CDNavigationController.Event?
    @Binding var action: CDNavigationController.Action?
    var content: () -> Content
    
    public init(config: CDNavigationViewConfiguration, backEvent: CDNavigationController.Event?, closeEvent: CDNavigationController.Event?, action: Binding<CDNavigationController.Action?> = .constant(nil), content: @escaping () -> Content) {
        self.config = config
        self.content = content
        self.backEvent = backEvent
        self.closeEvent = closeEvent
        self._action = action
    }
    
    public var body: some View{
        
        CDNaviationViewWrapper(
            statusBarColor: $config.statusBarColor,
            navigationBarBackgroundType:  $config.navigationBarBackgroundType,
            navigationBarTitleType: $config.navigationBarTitleType,
            closeImage:  $config.closeImage,
            backImage:  $config.backImage,
            isNavigationBarHidden:  $config.isNavigationBarHidden,
            isBackBtnHidden:  $config.isBackBtnHidden,
            isCloseBtnHidden:  $config.isCloseBtnHidden,
            navigationBarHeight: $config.navigationBarHeight,
            action: $action,//UIScreen.main.bounds.height*(183/2436),
            backEvent: backEvent,
            closeEvent: closeEvent,
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
                config.navigationBarTitleType = CDNavigationController.NavigationBarTitleType.text(title: title.title,
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
