//
//  CDURLSessionResponse.swift
//  Phonics
//
//  Created by Littlefox iOS Developer on 2023/07/18.
//  Copyright © 2023 com.littlefox. All rights reserved.
//

import Foundation
import Combine

public protocol Response_P: ModelType{
    
    associatedtype Model: ModelType
    
    var responseType: Response_E {get set}
    var data: Model {get set}
    init(responseType: Response_E, data: Model)
}

public enum Response_E{
    case ok(code: Int, message: String?)
    case error(code: Int, message: String?)
    
    public var message: String?{
        switch self {
        case .ok(_, let message):
            return message
        case .error(_, let message):
            return message
        }
    }
    
    public var isOK: Bool{
        switch self {
        case .ok(_, _):
            return true
        case .error(_, _):
            return false
        }
    }
    
    public var code: Int{
        switch self {
        case .ok(let code, _):
            return code
        case .error(let code, _):
            return code
        }
    }
}
