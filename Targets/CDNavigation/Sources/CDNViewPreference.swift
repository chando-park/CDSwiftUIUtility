//
//  CDNViewPreference.swift
//  CDNavigation
//
//  Created by Littlefox iOS Developer on 2023/08/24.
//

import SwiftUI

//뒤로가기 버튼 히든
public struct NViewBackButtonHiddenPreferenceKey: PreferenceKey {
    public static var defaultValue: Bool = false
    public static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

//타이틀
public struct NViewTitlePreferenceKey: PreferenceKey {
    
    public struct TitleInfo: Equatable{
        var title: String?
        var subTitle: String?
    }
    
    public static var defaultValue: TitleInfo = TitleInfo()
    public static func reduce(value: inout TitleInfo, nextValue: () -> TitleInfo) {
        value = nextValue()
    }
}

//상태바 색상
public struct NViewStatusBarColorPreferenceKey: PreferenceKey {
    public static var defaultValue: Color? = nil
    public static func reduce(value: inout Color?, nextValue: () -> Color?) {
        value = nextValue()
    }
}

//네비게이션바 히든 여부
public struct NViewBarHiddenPreferenceKey: PreferenceKey {
    public static var defaultValue: Bool = false
    public static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

//닫기 히든 여부
public struct NViewCloseButtonHiddenPreferenceKey: PreferenceKey {
    public static var defaultValue: Bool = false
    public static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

//닫기 버튼 이미지
public struct NViewCloseButtonImagePreferenceKey: PreferenceKey {
    public static var defaultValue: UIImage? = nil
    public static func reduce(value: inout UIImage?, nextValue: () -> UIImage?) {
        value = nextValue()
    }
}

//뒤로가기 버튼 이미지
public struct NViewBackButtonImagePreferenceKey: PreferenceKey {
    public static var defaultValue: UIImage? = nil
    public static func reduce(value: inout UIImage?, nextValue: () -> UIImage?) {
        value = nextValue()
    }
}

public struct NViewNavibarBackgrounTypePreferenceKey: PreferenceKey {
    public static var defaultValue: CDNavigationController.NavigationBarBackgroundType? = nil
    public static func reduce(value: inout CDNavigationController.NavigationBarBackgroundType?, nextValue: () -> CDNavigationController.NavigationBarBackgroundType?) {
        value = nextValue()
    }
}

//뷰 모디파이어
public extension View {

    func nViewIsBackButtonHidden(_ isHidden: Bool = true) -> some View {
        preference(key: NViewBackButtonHiddenPreferenceKey.self, value: isHidden)
    }
    
    func nViewTitle(_ title: String?, subTitle: String? = nil) -> some View {
        preference(key: NViewTitlePreferenceKey.self, value: NViewTitlePreferenceKey.TitleInfo(title: title, subTitle: subTitle))
    }
    
    func nViewStatusBarColor(_ color: Color) -> some View {
        preference(key: NViewStatusBarColorPreferenceKey.self, value: color)
    }
    
    func nViewIsNaviBarHidden(_ isHidden: Bool = true) -> some View {
        preference(key: NViewBarHiddenPreferenceKey.self, value: isHidden)
    }
    
    func nViewIsCloseButtonHidden(_ isHidden: Bool = true) -> some View {
        preference(key: NViewCloseButtonHiddenPreferenceKey.self, value: isHidden)
    }
    
    func nViewCloseButtonImage(_ image: UIImage? = nil) -> some View {
        preference(key: NViewCloseButtonImagePreferenceKey.self, value: image)
    }
    
    func nViewBackButtonImage(_ image: UIImage? = nil) -> some View {
        preference(key: NViewBackButtonImagePreferenceKey.self, value: image)
    }
    
    func nViewNavibarBackgrounType(_ type: CDNavigationController.NavigationBarBackgroundType? = nil) -> some View {
        preference(key: NViewNavibarBackgrounTypePreferenceKey.self, value: type)
    }
}
