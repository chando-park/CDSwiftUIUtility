//
//  CDActivityType.swift
//  CDActivityView
//
//  Created by Littlefox iOS Developer on 2023/09/19.
//

import SwiftUI

public enum CDActivityType: Equatable, Identifiable{
    case image(UIImage)
    case url(URL?)
    case text(String)
    
    public var id: String{
        "\(self)"////
    }
    
    public static func == (lhs: CDActivityType, rhs: CDActivityType) -> Bool {
        lhs.id == rhs.id
    }
    
    var toActivity: Any?{
        switch self {
        case .image(let image):
            return image
        case .url(let url):
            return url
        case .text(let string):
            return string
        }
    }
    
    var isUrl: Bool{
        switch self {
        case .url(_):
            return true
        default:
            return false
        }
    }
}
