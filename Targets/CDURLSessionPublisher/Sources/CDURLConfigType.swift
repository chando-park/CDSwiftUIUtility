//
//  APIConfig.swift
//  Phonics
//
//  Created by Littlefox iOS Developer on 2023/07/18.
//  Copyright © 2023 com.littlefox. All rights reserved.
//

import Foundation

public protocol CDURLConfigType{
    var headers: [String:String]? {get}
    var baseURL: String {get}
}
