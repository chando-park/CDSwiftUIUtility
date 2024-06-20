//
//  LoginAPI.swift
//  Phonics
//
//  Created by LittleFoxiOSDeveloper on 2023/06/29.
//  Copyright © 2023 com.littlefox. All rights reserved.
//

import Foundation
import Combine
import SwiftUI


public typealias ModelType = Decodable

public class CDURLSessionPublisher{
    
    public init(){}
    
    public func call<T: CDURLInfoType>(apiInfo: T) -> AnyPublisher<T.Response.Model, CDURLSessionError_E>{

        guard let url = URL(string: apiInfo.address) else{
            return AnyPublisher(Fail<T.Response.Model, CDURLSessionError_E>(error: .urlErr(message: "Invalid URL")))
        }

        print("🦊 request ======================= \nurl ::: \(apiInfo.urlRequest)\nmethod ::: \(apiInfo.urlRequest.httpMethod)\nheader ::: \(String(describing: apiInfo.urlRequest.allHTTPHeaderFields))\nparameter ::: \(String(describing: apiInfo.parameters))\n==================================")
        
        return URLSession.shared.dataTaskPublisher(for: apiInfo.urlRequest).tryMap { data, res in
            guard res is HTTPURLResponse else{
                throw CDURLSessionError_E.etcErr(message: "Server error")
            }
            return data
        }
        .decode(type: T.Response.self, decoder: JSONDecoder())
        .tryMap({ res -> T.Response.Model in
            print("🦊 response ::: \(res)")
            return res.data
        })
        .mapError { err in
            if let decodingError = err as? DecodingError {
                let message: String = {
                    switch decodingError {
                    case .typeMismatch(let any, let context):
                        return "could not find key \(any) in JSON: \(context.debugDescription)"
                    case .valueNotFound(let any, let context):
                        return "could not find key \(any) in JSON: \(context.debugDescription)"
                    case .keyNotFound(let codingKey, let context):
                        return "could not find key \(codingKey) in JSON: \(context.debugDescription)"
                    case .dataCorrupted(let context):
                        return "could not find key in JSON: \(context.debugDescription)"
                    @unknown default:
                        return err.localizedDescription
                    }
                }()
                
                return CDURLSessionError_E.decodingErr(message: message)
                
            } else if let error = err as? CDURLSessionError_E {
                return error
            } else {
                return CDURLSessionError_E.inServerError(code: (err as NSError).code, message: err.localizedDescription)
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
        
    }
}


public enum HTTPMethod: String{
    case GET
    case POST
    case PUT
    case DELETE
}

