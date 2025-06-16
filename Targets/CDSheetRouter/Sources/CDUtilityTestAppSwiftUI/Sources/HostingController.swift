//
//  HostingController.swift
//  CDWeb
//
//  Created by Littlefox iOS Developer on 2023/09/22.
//

import SwiftUI

public class OrientationLockedController<Content: View>: UIHostingController<OrientationLockedController._Root<Content>> {
    fileprivate class Box {
        var supportedOrientations: UIInterfaceOrientationMask
        init() {
            self.supportedOrientations = UIDevice.current.userInterfaceIdiom == .pad ? .landscape : [.portrait, .landscape]
        }
    }
    
    private var orientations: Box!
    override public var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        print("supportedInterfaceOrientations \(orientations.supportedOrientations == .portrait)")
        return orientations.supportedOrientations
    }
    public override var shouldAutorotate : Bool {
        return true
    }

    public init(rootView: Content) {
        let box = Box()
        let orientationRoot = _Root(contentView: rootView, box: box)
        self.orientations = box
        super.init(rootView: orientationRoot)
    }

    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public struct _Root<Content: View>: View {
        private let contentView: Content
        private let box: Box

        fileprivate init(contentView: Content, box: Box) {
            self.contentView = contentView
            self.box = box
        }

        public var body: some View {
            contentView
                .onPreferenceChange(SupportedOrientationsPreferenceKey.self) { value in
                    self.box.supportedOrientations = value
            }
        }
    }
}

struct SupportedOrientationsPreferenceKey: PreferenceKey {
    typealias Value = UIInterfaceOrientationMask
    static var defaultValue: UIInterfaceOrientationMask {
        UIDevice.current.userInterfaceIdiom == .pad ? .landscape : .portrait
    }
    
    public static func reduce(value: inout UIInterfaceOrientationMask, nextValue: () -> UIInterfaceOrientationMask) {
        value.formIntersection(nextValue())
    }
}

extension View {
    public func supportedOrientations(_ supportedOrientations: UIInterfaceOrientationMask) -> some View {
        preference(key: SupportedOrientationsPreferenceKey.self, value: supportedOrientations)
    }
}
