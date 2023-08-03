//
//  CDWebAddress.swift
//  CDWeb
//
//  Created by Littlefox iOS Developer on 2023/08/03.
//

import Foundation

public protocol CDWebAddress_P: RawRepresentable where RawValue == String {
    var url: URL?{ get }
    var headers: [String:String]{get}
}

extension CDWebAddress_P{
    var request: URLRequest?{
        if let url = url {
            var request = URLRequest(url: url)
            self.headers.forEach { key,value in
                request.setValue(value, forHTTPHeaderField: key)
            }
            return request
        }
        return nil
    }
}
