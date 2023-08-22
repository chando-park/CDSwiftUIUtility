//
//  CDSheetContext.swift
//  CDUtilityTestAppSwiftUI
//
//  Created by Littlefox iOS Developer on 2023/08/17.
//

import SwiftUI

public enum SheetAnimation: Equatable{
    case full(animationOn: Bool)
    case front
    case push
    
    var isAnimationOn: Bool{
        switch self {
        case .full(let animationOn):
            return animationOn
        case .front:
            return true
        case .push:
            return true
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

public struct SheetRouterContext<R: SheetRouterProtocol>{
    let router: R
    let animation: SheetAnimation
}

public extension SheetRouterProtocol{
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: String { "\(self)" }
}

