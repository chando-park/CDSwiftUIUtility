//
//  CDRouteOperation.swift
//  CDUtility
//
//  Created by Littlefox iOS Developer on 2023/08/17.
//

import SwiftUI



public class PlatformOperator<SheetRouter:SheetRouterProtocol, VM: PlatformOperatorVM_P>: MovingSheetOperator<SheetRouter> {
    public weak var viewModel: VM?
    
    public init(viewModel: VM) {
        self.viewModel = viewModel
    }

    //View의 이벤트를 받아 ViewMdoel로 보냄
    public func send(_ event: VM.Event){
        self.viewModel?.received(event: event)
    }
}



