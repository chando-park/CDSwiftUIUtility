//
//  CDOrientationLockConfiguration.swift
//  CDOrientation
//
//  Created by Littlefox iOS Developer on 12/15/23.
//

import UIKit

public protocol CDOrientationLockConfiguration_P{
    var `default`: UIInterfaceOrientationMask {get set}
}

public struct CDOrientationLockConfiguration: CDOrientationLockConfiguration_P{
    public var `default`: UIInterfaceOrientationMask
    
    public init(orientation: UIInterfaceOrientationMask){
        self.default = orientation
    }
}

