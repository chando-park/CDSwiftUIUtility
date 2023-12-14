//
//  MovingSheetOperator.swift
//  CDSheetRouter
//
//  Created by Littlefox iOS Developer on 2023/09/06.
//

import SwiftUI
import Combine

public class MovingSheetOperator<SheetRouter:SheetRouterProtocol>: ObservableObject {
    @Published public var sheets: [SheetRouterContext<SheetRouter>] = []
    
    public init(){}
    //View의 화면 이동
    public func go(_ sheet: SheetRouter?, animation: SheetAnimation){
        if let s = sheet{
            self.sheets.append(SheetRouterContext(router: s, animation: animation))
        }
    }
    
    public func pop(){
        _ = self.sheets.popLast()
    }
}

public extension View {
    func routering<SheetRouter: SheetRouterProtocol>(_ sheets: Binding<[SheetRouterContext<SheetRouter>]>, sheetDetector: ((SheetRouter?) -> Void)? = nil) -> some View {
        modifier(MovingRoute(sheets: sheets, sheetDetector: sheetDetector))
    }
}

struct EmailSheet: SheetRouterProtocol{
    let to: String
    let subject: String
    let message: String
    func buildView(isSheeted: Binding<Bool>) -> some View {
        EmailComposeView(to: to, subject: subject, message: message)
    }
}
