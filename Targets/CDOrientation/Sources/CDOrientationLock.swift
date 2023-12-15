//
//  CDOrientationLock.swift
//  Phonics
//
//  Created by Littlefox iOS Developer on 2023/09/25.
//  Copyright © 2023 com.littlefox. All rights reserved.
//

import UIKit
import SwiftUI

public class CDOrientationLock{
    
//    public static let `default`: UIInterfaceOrientationMask = .portrait
    
    private var isFirstSetting: Bool = false
    private var `default`: UIInterfaceOrientationMask = .portrait
    public var currentMask: UIInterfaceOrientationMask = .portrait
    
    public static var shared = CDOrientationLock()
    
    func set(config: CDOrientationLockConfiguration_P){
        
        guard self.isFirstSetting else{
            return
        }
        
        defer{
            self.isFirstSetting = true
        }
        
        self.default = config.default
        self.currentMask = self.default
    }
    
    public func rotate(orientation: UIInterfaceOrientationMask){
        if #available(iOS 16.0, *) {
            UIApplication.shared.connectedScenes.forEach { scene in
                if let windowScene = scene as? UIWindowScene {
                    windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: orientation))
                }
            }
            UIViewController.attemptRotationToDeviceOrientation()
        } else {
            if orientation == .landscape {
                UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
            } else {
                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            }
        }
        
        CDOrientationLock.shared.currentMask = orientation
    }
    
    public func recover(){
        
        CDOrientationLock.shared.currentMask = self.`default`
        
        if #available(iOS 16.0, *) {
            UIApplication.shared.connectedScenes.forEach { scene in
                if let windowScene = scene as? UIWindowScene {
                    windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: self.default))
                }
            }
        } else {
            if self.default == .landscape {
                UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
            } else {
                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            }
        }
        
        
    }
}

