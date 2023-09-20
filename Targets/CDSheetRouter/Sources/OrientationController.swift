//
//  File.swift
//  
//
//  Created by LittleFoxiOSDeveloper on 2023/09/20.
//

import Foundation
import UIKit
import SwiftUI

public class OrientationLockedController<Content: View>: UIHostingController<OrientationLockedController.Root<Content>>{
    
    public class OrientationsHolder{
        var supportedOrientations: UIInterfaceOrientationMask
        
        init() {
            self.supportedOrientations = UIDevice.current.userInterfaceIdiom == .pad ? .all : .allButUpsideDown
        }
    }
    
    public var orientations: OrientationsHolder!
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        orientations.supportedOrientations
    }
    
    
    public init(rootView: Content) {
        let orientationsHolder = OrientationsHolder()
        let orientationRoot = Root(contentView: rootView, orientationsHolder: orientationsHolder)
        
        super.init(rootView: orientationRoot)
        self.orientations = orientationsHolder
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public struct Root<Content: View>: View{
        let contentView: Content
        let orientationsHolder: OrientationsHolder
        
        public var body: some View{
            contentView
                .onPreferenceChange(SupportedOrientationsPreferenceKey.self) {
                    orientationsHolder.supportedOrientations = $0
                }
        }
    }
}

extension View{
    func supportedOrientation(_ supportedOrientation: UIInterfaceOrientationMask) -> some View{
        preference(key: SupportedOrientationsPreferenceKey.self, value: supportedOrientation)
    }
    
    public func landscapeFullScreenCover(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> some View) -> some View{
        modifier(LandscapeFullScreenCover(isPresented: isPresented, coverContent: content))
    }
}

//PreferenceKey
struct SupportedOrientationsPreferenceKey: PreferenceKey{
    static var defaultValue: UIInterfaceOrientationMask{
        UIDevice.current.userInterfaceIdiom == .pad ? .all : .portrait
    }

    static func reduce(value: inout UIInterfaceOrientationMask, nextValue: () -> UIInterfaceOrientationMask) {
        value.formIntersection(nextValue())
    }
}

struct LandscapeFullScreenCover<CoverContent: View>: ViewModifier{
    
    @Binding var isPresented: Bool
    @ViewBuilder let coverContent: () -> CoverContent
    @State private var supportedOrientations: UIInterfaceOrientationMask = .portrait
    
    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $isPresented) {
                coverContent()
            }
            .onChange(of: isPresented) {
                supportedOrientations = $0 ? .landscape : .portrait
            }
//            .onDisappear(perform: {
//                self.isPresented = false
//            })
            .supportedOrientation(supportedOrientations)
    }
}
