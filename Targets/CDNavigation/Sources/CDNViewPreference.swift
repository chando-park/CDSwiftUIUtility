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


public struct NViewBackButtonHiddenViewModifier: ViewModifier {
    @State var isBackButtonHiddenView: Bool? = nil
    private let __isBackButtonHiddenView: Bool
    
    init(isBackButtonHiddenView: Bool) {
        self.__isBackButtonHiddenView = isBackButtonHiddenView
    }
    
    public func body(content: Content) -> some View {
        content
            .preference(key: NViewBackButtonHiddenPreferenceKey.self, value: isBackButtonHiddenView ?? true)
            .onAppear {
                self.isBackButtonHiddenView = self.__isBackButtonHiddenView
            }
    }
}

//타이틀
public struct NViewTitlePreferenceKey: PreferenceKey {
    
    public struct TitleInfo: Equatable{
        var title: String?
        var subTitle: String?
    }
    
//    public typealias TitleInfo = (title: String?, subTitle: String?)
    public static var defaultValue: TitleInfo = TitleInfo()
    public static func reduce(value: inout TitleInfo, nextValue: () -> TitleInfo) {
        value = nextValue()
    }
}

public struct NViewTitlePreferenceKeyViewModifier: ViewModifier {
    
    @State var title: NViewTitlePreferenceKey.TitleInfo = NViewTitlePreferenceKey.TitleInfo()
    private let __title: NViewTitlePreferenceKey.TitleInfo

    init(title: String?, subTitle: String? = nil) {
        self.__title = NViewTitlePreferenceKey.TitleInfo(title: title,subTitle: subTitle)
    }
    
    public func body(content: Content) -> some View {
        content
            .preference(key: NViewTitlePreferenceKey.self, value: title)
            .onAppear {
                self.title = self.__title
            }
    }
}

//상태바 색상
public struct NViewStatusBarColorPreferenceKey: PreferenceKey {
    public static var defaultValue: Color = .clear
    public static func reduce(value: inout Color, nextValue: () -> Color) {
        value = nextValue()
    }
}


public struct NViewStatusBarColorPreferenceKeyViewModifier: ViewModifier {
    @State var color: Color = .clear
    private let __color: Color
    
    init(color: Color) {
        self.__color = color
    }
    
    public func body(content: Content) -> some View {
        content
            .preference(key: NViewStatusBarColorPreferenceKey.self, value: color)
            .onAppear {
                self.color = self.__color
            }
    }
}

//네비게이션바 히든 여부
public struct NViewBarHiddenPreferenceKey: PreferenceKey {
    public static var defaultValue: Bool = false
    public static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}


public struct NViewBarHiddenPreferenceKeyViewModifier: ViewModifier {
    @State var isHidden: Bool = false
    private let __isHidden: Bool
    
    init(isHidden: Bool) {
        self.__isHidden = isHidden
    }
    
    public func body(content: Content) -> some View {
        content
            .preference(key: NViewBarHiddenPreferenceKey.self, value: isHidden)
            .onAppear {
                self.isHidden = self.__isHidden
            }
    }
}


//네비게이션바 히든 여부
public struct NViewCloseButtonHiddenPreferenceKey: PreferenceKey {
    public static var defaultValue: Bool = false
    public static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}


public struct NViewCloseButtonHiddenPreferenceKeyViewModifier: ViewModifier {
    @State var isHidden: Bool = false
    private let __isHidden: Bool
    
    init(isHidden: Bool) {
        self.__isHidden = isHidden
    }
    
    public func body(content: Content) -> some View {
        content
            .preference(key: NViewCloseButtonHiddenPreferenceKey.self, value: isHidden)
            .onAppear {
                self.isHidden = self.__isHidden
            }
    }
}

//뷰 모디파이어
public extension View {
    func isNViewBackButtonHidden(_ isHidden: Bool = true) -> some View {
        modifier(NViewBackButtonHiddenViewModifier(isBackButtonHiddenView: isHidden))
    }
    
    func nViewTitle(_ title: String?, subTitle: String? = nil) -> some View {
        modifier(NViewTitlePreferenceKeyViewModifier(title: title, subTitle: subTitle))
    }
    
    func nViewStatusBarColor(_ color: Color) -> some View {
        modifier(NViewStatusBarColorPreferenceKeyViewModifier(color: color))
    }
    
    func nViewIsNaviBarHidden(_ isHidden: Bool = true) -> some View {
        modifier(NViewBarHiddenPreferenceKeyViewModifier(isHidden: isHidden))
    }
    
    func nViewIsCloseButtonHidden(_ isHidden: Bool = true) -> some View {
        modifier(NViewCloseButtonHiddenPreferenceKeyViewModifier(isHidden: isHidden))
    }
}
