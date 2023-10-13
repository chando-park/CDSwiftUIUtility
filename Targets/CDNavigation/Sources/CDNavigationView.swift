//
//  CDNavigationView.swift
//  CDNavigation
//
//  Created by Littlefox iOS Developer on 2023/08/24.
//

import SwiftUI

public struct CDNavigationView<Content: View>: View{

//    @ObservedObject var config: CDNavigationViewConfiguration
    @State var statusBarColor: Color
    @State var navigationBarBackgroundType: CDNavigationController.NavigationBarBackgroundType
    @State var navigationBarTitleType: CDNavigationController.NavigationBarTitleType
    @State var navigationBarHeight: CGFloat
    @State var closeImage: UIImage?
    @State var backImage: UIImage?
    @State var isNavigationBarHidden: Bool
    @Binding var isBackBtnHidden: Bool
    @Binding var isCloseBtnHidden: Bool
    var backEvent: CDNavigationController.Event?
    var closeEvent: CDNavigationController.Event?
    @Binding var action: CDNavigationController.Action?
    @Binding var isUsePreference: Bool
    var content: () -> Content

    public init(statusBarColor: Color, navigationBarBackgroundType: CDNavigationController.NavigationBarBackgroundType, navigationBarTitleType: CDNavigationController.NavigationBarTitleType, navigationBarHeight: CGFloat, closeImage: UIImage? = nil, backImage: UIImage? = nil, isNavigationBarHidden: Bool, isBackBtnHidden: Binding<Bool>, isCloseBtnHidden: Binding<Bool>, backEvent: CDNavigationController.Event? = nil, closeEvent: CDNavigationController.Event? = nil, action: Binding<CDNavigationController.Action?> = .constant(nil), isUsePreference: Binding<Bool> = .constant(true), content: @escaping () -> Content) {
        self.statusBarColor = statusBarColor
        self.navigationBarBackgroundType = navigationBarBackgroundType
        self.navigationBarTitleType = navigationBarTitleType
        self.navigationBarHeight = navigationBarHeight
        self.closeImage = closeImage
        self.backImage = backImage
        self.isNavigationBarHidden = isNavigationBarHidden
        self._isBackBtnHidden = isBackBtnHidden
        self._isCloseBtnHidden = isCloseBtnHidden
        self.backEvent = backEvent
        self.closeEvent = closeEvent
        self._action = action
        self._isUsePreference = isUsePreference
        self.content = content
    }
    
    public var body: some View{
        
        CDNaviationViewWrapper(
            statusBarColor: $statusBarColor,
            navigationBarBackgroundType:  $navigationBarBackgroundType,
            navigationBarTitleType: $navigationBarTitleType,
            closeImage:  $closeImage,
            backImage:  $backImage,
            isNavigationBarHidden:  $isNavigationBarHidden,
            isBackBtnHidden:  $isBackBtnHidden,
            isCloseBtnHidden:  $isCloseBtnHidden,
            navigationBarHeight: $navigationBarHeight,
            action: $action,//UIScreen.main.bounds.height*(183/2436),
            backEvent: backEvent,
            closeEvent: closeEvent,
            content: content,
            callback: { n, c in
            })
            .onPreferenceChange(NViewBackButtonHiddenPreferenceKey.self) { isHidden in
                guard self.isUsePreference else{
                    return
                }
                isBackBtnHidden = isHidden
            }
            .onPreferenceChange(NViewTitlePreferenceKey.self) { title in
                guard self.isUsePreference else{
                    return
                }
                
                let font = navigationBarTitleType.fontInfo
                let subFont = navigationBarTitleType.subFontInfo
                let color = navigationBarTitleType.color
                navigationBarTitleType = CDNavigationController.NavigationBarTitleType.text(title: title.title,
                                                                                            subTitle: title.subTitle,
                                                                                            color: color,
                                                                                            font: font,
                                                                                            subTitleFont: subFont)
            }
            .onPreferenceChange(NViewStatusBarColorPreferenceKey.self) { color in
                guard self.isUsePreference else{
                    return
                }
                
                guard let color = color else{
                    return
                }
                
                statusBarColor = color
                
            }
            .onPreferenceChange(NViewBarHiddenPreferenceKey.self) { isHidden in
                guard self.isUsePreference else{
                    return
                }
                isNavigationBarHidden = isHidden
            }
            .onPreferenceChange(NViewCloseButtonHiddenPreferenceKey.self) { isHidden in
                guard self.isUsePreference else{
                    return
                }
                isCloseBtnHidden = isHidden
            }
            .onPreferenceChange(NViewCloseButtonImagePreferenceKey.self) { image in
                guard self.isUsePreference else{
                    return
                }
                closeImage = image
            }
            .onPreferenceChange(NViewBackButtonImagePreferenceKey.self) { image in
                guard self.isUsePreference else{
                    return
                }
                backImage = image
            }
            .onPreferenceChange(NViewNavibarBackgrounTypePreferenceKey.self) { type in
                guard self.isUsePreference else{
                    return
                }
                if let type = type{
                    navigationBarBackgroundType = type
                }
            }
            .ignoresSafeArea([.container])
        
    }
}
