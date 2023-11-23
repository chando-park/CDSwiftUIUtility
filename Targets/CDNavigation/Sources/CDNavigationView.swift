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
