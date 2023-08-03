//
//  SharedHeader.swift
//  CDWeb
//
//  Created by Littlefox iOS Developer on 2023/08/03.
//

import Foundation


public class SharedHeaders {
    public static let list = SharedHeaders()
    public var common: [String:String] = [:]

    public func add(for key: String, value: String) -> [String:String]{
        var common = common
        common[key] = value
        return common
    }
    
    public func setCommon(heaers: [String:String]){
        common = heaers
    }
}


