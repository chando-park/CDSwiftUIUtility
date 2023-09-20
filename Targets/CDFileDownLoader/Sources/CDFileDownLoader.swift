//
//  CDFileDownLoader.swift
//  CDUtility
//
//  Created by Littlefox iOS Developer on 2023/09/13.
//

import SwiftUI
import Combine


public enum CDFileDownLoaderError: Error{
    case inValidURL
    case writingError
    case inerError(Error)
    
    var message: String{
        switch self {
        case .inValidURL:
            return "inValidURL"
        case .writingError:
            return "writingError"
        case .inerError(let error):
            return error.localizedDescription
        }
    }
}

public enum CDFileName{
    
    enum Storage{
        case document
        case cache
    }
    
    case pdf(String)
    case png(String)
    case jpg(String)
    case txt(String)
    
    var name: String{
        switch self {
        case .pdf(let string):
            return string
        case .png(let string):
            return string
        case .jpg(let string):
            return string
        case .txt(let string):
            return string
        }
    }
    
    var extention: String{
        switch self {
        case .pdf(_):
            return "pdf"
        case .png(_):
            return "png"
        case .jpg(_):
            return "jpg"
        case .txt(_):
            return "txt"
        }
    }
    
    var destination: URL{
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("\(self.name).\(self.extention)")
    }
    
}


public class CDFileDownLoader {
    
    public static let shared = CDFileDownLoader()
    
    var cancellables = Set<AnyCancellable>()
    
    public init(){}
    
    public func downloadFile(url: URL?, name: CDFileName, onStart: () -> Void, onEnd: @escaping (_ destination: URL?, _ error: CDFileDownLoaderError?) -> Void){
        
        onStart()
        
        guard let fileURL = url else {
            onEnd(nil, .inValidURL)
            return
        }
        
        let destination = name.destination
        
        URLSession.shared.dataTaskPublisher(for: fileURL)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Download error: \(error)")
                    onEnd(nil, .inerError(error))
                }
            }, receiveValue: { value in
                let data = value.data
                do {
                    try data.write(to: destination)
                    onEnd(destination, nil)
                    print("File downloaded to: \(destination)")
                } catch {
                    print("Error saving downloaded file: \(error)")
                    onEnd(nil, .writingError)
                }
            })
            .store(in: &cancellables)
    }
    
}
