//
//  CDRouteOperation.swift
//  CDUtility
//
//  Created by Littlefox iOS Developer on 2023/08/17.
//

import SwiftUI

public class SheetRouterOperator<SheetRouter:SheetRouterProtocol>: ObservableObject {
    @Published public var sheets: [SheetRouterContext<SheetRouter>] = []
    
    public func go(_ sheet: SheetRouter?, animation: SheetAnimation){
        if let s = sheet{
            self.sheets.append(SheetRouterContext(router: s, animation: animation))
        }
    }
    
    public init() {}
}


public extension View {
    func routering<SheetRouter: SheetRouterProtocol>(_ sheets: Binding<[SheetRouterContext<SheetRouter>]>) -> some View {
        modifier(Routering(sheets: sheets))
    }
}

