//
//  CDViewActionModifier.swift
//  CDNavigation
//
//  Created by Littlefox iOS Developer on 11/22/23.
//

import SwiftUI

public extension View {
    func bindNavigationAction<C: CDNavigationConfiguration_P>(_ c: C, action: Binding<CDNavigationController.Action?>) -> some View {
        modifier(NavigationAction(c: c, action: action))
    }
}

public struct NavigationAction<C: CDNavigationConfiguration_P>: ViewModifier {
    @ObservedObject public var c: C
    @Binding var action: CDNavigationController.Action?
    
    public func body(content: Content) -> some View {
        content
            .onChange(of: action) { action in
                self.c.action = action
            }
    }
}
