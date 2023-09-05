//
//  PlatformOperatorConfiguration.swift
//  CDSheetRouter
//
//  Created by Littlefox iOS Developer on 2023/09/06.
//

import Foundation

public protocol PlatformOperatorVM_P: ObservableObject{
    associatedtype Event: EventKind
    func received(event: Event)
}

public protocol EventKind{}
extension EventKind{
    public var id: String{
        "\(self)"
    }
}
