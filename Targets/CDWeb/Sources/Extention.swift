//
//  Extention.swift
//  CDWeb
//
//  Created by Littlefox iOS Developer on 2023/08/02.
//

import WebKit

extension String{
    var encodeUrl: String?{
        return self.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
    }
    
    var decodeUrl: String?{
        return self.removingPercentEncoding
    }
}

