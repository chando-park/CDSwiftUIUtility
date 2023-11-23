//
//  CDNavigationView.swift
//  CDNavigation
//
//  Created by Littlefox iOS Developer on 2023/08/24.
//

import SwiftUI


public struct CDNavigation<Content: View>: View{

    @ObservedObject public var config: CDNavigationConfiguration
    public var content: () -> Content

    public init(config: CDNavigationConfiguration, content: @escaping () -> Content) {
        self.config = config
        self.content = content
    }
    
    public var body: some View{
        CDNavigationWrapper(config: config, content: content)
            .ignoresSafeArea([.container])
        
    }
}


public extension View {
    func navigationAction<C: CDNavigationConfiguration_P>(_ c: C, action: Binding<CDNavigationController.Action?>) -> some View {
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
