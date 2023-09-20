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
    case landscapeFull(animationOn: Bool)
    case front(_PresentationDetent)
    case push
    
    var isAnimationOn: Bool{
        switch self {
        case .full(let animationOn):
            return animationOn
        case .landscapeFull(let animationOn):
            return animationOn
        case .front(_):
            return true
        case .push:
            return true
        }
    }
    
    var presentationDetent: _PresentationDetent?{
        switch self {
        case .full(_):
            return nil
        case .landscapeFull(_):
            return nil
        case .front(let presentationDetent):
            return presentationDetent
        case .push:
            return nil
        }
    }
    
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

