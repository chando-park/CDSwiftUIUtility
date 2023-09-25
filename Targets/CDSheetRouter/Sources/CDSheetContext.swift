//
//  CDSheetContext.swift
//  CDUtilityTestAppSwiftUI
//
//  Created by Littlefox iOS Developer on 2023/08/17.
//

import SwiftUI

//@available(iOS 16.0, *)
public enum SheetAnimation: Equatable{
    
    public enum _PresentationDetent{
        case medium
        case large
    }
    
    case full(animationOn: Bool)
    case front
    case activity(_PresentationDetent)
    case push
    
    var isAnimationOn: Bool{
        switch self {
        case .full(let animationOn):
            return animationOn
        default:
            return true
        }
    }
    
    var presentationDetent: _PresentationDetent?{
        switch self {
        case .activity(let presentationDetent):
            return presentationDetent
        default:
            return nil
        }
    }
    
//    var orientationMask: UIInterfaceOrientationMask{
//        switch self {
//        case .full(_, let orientation):
//            return orientation
//        default:
//            return CDOrientationLock.default
//
//        }
//    }
    
    static public func == (lhs: SheetAnimation, rhs: SheetAnimation) -> Bool {
        "\(lhs.self)" == "\(rhs.self)"
    }
}

public protocol SheetRouterProtocol: Identifiable, Equatable {
    associatedtype Sheet: View
    @ViewBuilder func buildView(isSheeted: Binding<Bool>) -> Sheet
}

public struct SheetRouterContext<R: SheetRouterProtocol>: Equatable{
    let router: R
    let animation: SheetAnimation
}

public extension SheetRouterProtocol{
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: String { "\(self)" }
}

