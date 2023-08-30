//
//  Route.swift
//  Phonics
//
//  Created by LittleFoxiOSDeveloper on 2023/06/28.
//  Copyright © 2023 com.littlefox. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

public struct MovingRoute<SheetRouter: SheetRouterProtocol>: ViewModifier {
    @Binding var sheets: [SheetRouterContext<SheetRouter>]
    
    private var isActiveBinding: Binding<Bool> {
        if sheets.isEmpty {
            return .constant(false)
        } else {
            return Binding(
                get: { sheets.isEmpty == false },
                set: { isShowing in
                    if !isShowing, let _ = sheets.last {
                        sheets.removeLast()
                    }
                }
            )
        }
    }
    
    private var isPushSheeted: Binding<Bool> {
        sheets.last?.animation == .push ? isActiveBinding : .constant(false)
    }
    
    private var isFullSheeted: Binding<Bool> {
        
        switch sheets.last?.animation {
        case .full(_):
            return isActiveBinding
        default:
            return .constant(false)
        }
    }
    
    private var isFrontSheeted: Binding<Bool> {
        sheets.last?.animation == .front ? isActiveBinding : .constant(false)
    }
    
    public func body(content: Content) -> some View {
//        if sheets.isEmpty {
//            content
//        } else {
            content
                .fullScreenCover(isPresented: isFullSheeted) {
                    sheets.last?.router.buildView(isSheeted: isFullSheeted)
                        
                }
                .sheet(isPresented: isFrontSheeted) {
                    sheets.last?.router.buildView(isSheeted: isFrontSheeted)
                }
                .background(
                    NavigationLink(
                        destination: sheets.last?.router.buildView(isSheeted: isPushSheeted),
                        isActive: isPushSheeted,
                        label: EmptyView.init
                    )
                    .hidden()
                )
                .transaction({ t in
                    t.disablesAnimations = sheets.last?.animation.isAnimationOn == false
                })
//        }
    }
}


//extension View{
//    @ViewBuilder
//    public func moveSheet<SheetRouter: SheetRouterProtocol>(_  sheets: [SheetRouterContext<SheetRouter>]) -> some View{
//        
//        var isActiveBinding: Binding<Bool> {
//            if sheets.isEmpty {
//                return .constant(false)
//            } else {
//                return Binding(
//                    get: { sheets.isEmpty == false },
//                    set: { isShowing in
//                        if !isShowing, let _ = sheets.last {
////                            sheets.removeLast()
//                        }
//                    }
//                )
//            }
//        }
//        
//        var isPushSheeted: Binding<Bool> {
//            sheets.last?.animation == .push ? isActiveBinding : .constant(false)
//        }
//        
//        var isFullSheeted: Binding<Bool> {
//            
//            switch sheets.last?.animation {
//            case .full(_):
//                return isActiveBinding
//            default:
//                return .constant(false)
//            }
//        }
//        
//        var isFrontSheeted: Binding<Bool> {
//            sheets.last?.animation == .front ? isActiveBinding : .constant(false)
//        }
//        
//        if sheets.isEmpty {
//            self
//        } else {
//            self
//                .fullScreenCover(isPresented: isFullSheeted) {
//                    sheets.last?.router.buildView(isSheeted: isFullSheeted)
//                        
//                }
//                .sheet(isPresented: isFrontSheeted) {
//                    sheets.last?.router.buildView(isSheeted: isFrontSheeted)
//                }
//                .background(
//                    NavigationLink(
//                        destination: sheets.last?.router.buildView(isSheeted: isPushSheeted),
//                        isActive: isPushSheeted,
//                        label: EmptyView.init
//                    )
//                    .hidden()
//                )
//                .transaction({ t in
//                    t.disablesAnimations = sheets.last?.animation.isAnimationOn == false
//                })
//        }
//    }
//}
