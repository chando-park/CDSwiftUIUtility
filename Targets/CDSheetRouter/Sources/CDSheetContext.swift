//
//  CDSheetContext.swift
//  CDUtilityTestAppSwiftUI
//
//  Created by Littlefox iOS Developer on 2023/08/17.
//

import SwiftUI

public enum SheetAnimation{
    case none
    case full
    case front
    case push
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
}

