//
//  Coordinator.swift
//  Phonics
//
//  Created by LittleFoxiOSDeveloper on 2023/06/28.
//  Copyright © 2023 com.littlefox. All rights reserved.
//

import Foundation
import SwiftUI
import Combine


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

public struct Routering<SheetRouter: SheetRouterProtocol>: ViewModifier {
    @Binding var sheets: [SheetRouterContext<SheetRouter>]
    
    
    private var isActiveBinding: Binding<Bool> {
        if sheets.count == 0 {
            return .constant(false)
        }else{
            return Binding(
                get: {
                    sheets.count > 0
                },
                set: { isShowing in
                    if isShowing == false{
                        if  let _ = sheets.last{
                            sheets.removeLast()
                        }
                    }
                })
        }
    }
    
    private var isPusheSheeted: Binding<Bool> {
        sheets.last?.animation == .push ? isActiveBinding : .constant(false)
    }
    
    private var isFullSheeted: Binding<Bool> {
        sheets.last?.animation == .full ? isActiveBinding : .constant(false)
    }
    
    private var isFrontSheeted: Binding<Bool> {
        sheets.last?.animation == .front ? isActiveBinding : .constant(false)
    }
    
    public func body(content: Content) -> some View {
        
        if sheets.isEmpty {
            content
        }else{
            content
                .fullScreenCover(isPresented: isFullSheeted) {
                    sheets.last?.router.buildView(isSheeted: isFullSheeted)
                }
                .sheet(isPresented: isFrontSheeted, content: {
                    sheets.last?.router.buildView(isSheeted: isFrontSheeted)
                })
                .background(
                    NavigationLink(
                        destination: sheets.last?.router.buildView(isSheeted: isPusheSheeted),
                        isActive: isPusheSheeted,
                        label: EmptyView.init
                    )
                    .hidden()
                )
        }
        
        
    }
}

public extension View {
    func routering<SheetRouter: SheetRouterProtocol>(_ sheets: Binding<[SheetRouterContext<SheetRouter>]>) -> some View {
        modifier(Routering(sheets: sheets))
    }
}

public class SheetRouterOperator<SheetRouter:SheetRouterProtocol>: ObservableObject {
    @Published public var sheets: [SheetRouterContext<SheetRouter>] = []
    
    public func go(_ sheet: SheetRouter?, animation: SheetAnimation){
        if let s = sheet{
            self.sheets.append(SheetRouterContext(router: s, animation: animation))
        }
    }
    
    public init() {}
}
