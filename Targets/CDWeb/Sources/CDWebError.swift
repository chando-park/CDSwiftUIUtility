//
//  CDWebError.swift
//  CDWeb
//
//  Created by Littlefox iOS Developer on 2023/08/04.
//

import Foundation


public enum CDWebError: Error{
    case invalidURL
    case specificError(Int,String)
    
    var code: Int{
        switch self {
        case .invalidURL:
            return 1001
        case .specificError(let code,_):
            return code
        }
    }
    
    var message: String{
        switch self {
        case .invalidURL:
            return "invalid error"
        case .specificError(_,let message):
            return message
        }
    }
    
    func log(){
        print("Error Code: \(code), Message: \(message)")
    }
}
