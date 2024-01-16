//
//  File.swift
//  CDNavigation
//
//  Created by Littlefox iOS Developer on 1/3/24.
//

import UIKit

extension UIColor{
    static public func getDeviceSpecificValue<T>(forPad: T, forPhone: T) -> T{
        if UIDevice.current.userInterfaceIdiom == .pad{
            return forPad
        }else{
            return forPhone
        }
    }
}

extension Bool{
    static public func getDeviceSpecificValue<T>(forPad: T, forPhone: T) -> T{
        if UIDevice.current.userInterfaceIdiom == .pad{
            return forPad
        }else{
            return forPhone
        }
    }
}

extension CDNavigationController.NavigationBarBackgroundType{
    static public func getDeviceSpecificValue<T>(forPad: T, forPhone: T) -> T{
        if UIDevice.current.userInterfaceIdiom == .pad{
            return forPad
        }else{
            return forPhone
        }
    }
}

extension CDNavigationController.NavigationBarTitleType{
    static public func getDeviceSpecificValue<T>(forPad: T, forPhone: T) -> T{
        if UIDevice.current.userInterfaceIdiom == .pad{
            return forPad
        }else{
            return forPhone
        }
    }
}

extension CGFloat{
    static public func getDeviceSpecificValue<T>(forPad: T, forPhone: T) -> T{
        if UIDevice.current.userInterfaceIdiom == .pad{
            return forPad
        }else{
            return forPhone
        }
    }
}

extension UIImage{
    static public func getDeviceSpecificValue<T>(forPad: T, forPhone: T) -> T{
        if UIDevice.current.userInterfaceIdiom == .pad{
            return forPad
        }else{
            return forPhone
        }
    }
}
