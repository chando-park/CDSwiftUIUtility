//
//  CDNViewPreference.swift
//  CDNavigation
//
//  Created by Littlefox iOS Developer on 2023/08/24.
//

import SwiftUI

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
                print("self.isBackButtonHiddenView \(String(describing: self.isBackButtonHiddenView))")
            }
    }
}



public extension View {
    func isNViewBackButtonHiddenView(_ isHidden: Bool = false) -> some View {
        modifier(NViewBackButtonHiddenViewModifier(isBackButtonHiddenView: isHidden))
    }
}
