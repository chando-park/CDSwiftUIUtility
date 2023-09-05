//
//  CDRouteOperation.swift
//  CDUtility
//
//  Created by Littlefox iOS Developer on 2023/08/17.
//

import SwiftUI

public class PlatformOperator<SheetRouter:SheetRouterProtocol, VM: PlatformOperatorVM_P>: ObservableObject {
    @Published public var sheets: [SheetRouterContext<SheetRouter>] = []
    private weak var viewModel: VM?
    
    public init(viewModel: VM) {
        self.viewModel = viewModel
    }
    
    //View의 화면 이동
    public func go(_ sheet: SheetRouter?, animation: SheetAnimation){
        if let s = sheet{
            self.sheets.append(SheetRouterContext(router: s, animation: animation))
        }
    }
    
    //View의 이벤트를 받아 ViewMdoel로 보냄
    public func send(_ event: VM.Event){
        self.viewModel?.received(event: event)
    }
}


public extension View {
    func routering<SheetRouter: SheetRouterProtocol>(_ sheets: Binding<[SheetRouterContext<SheetRouter>]>) -> some View {
        modifier(MovingRoute(sheets: sheets))
    }
}


public protocol PlatformOperatorVM_P: ObservableObject{
    associatedtype Event: EventKind
    func received(event: Event)
}

public protocol EventKind{
    
}

