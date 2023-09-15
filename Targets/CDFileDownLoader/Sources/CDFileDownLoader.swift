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


public class CDFileDownLoader {
    
    public static let shared = CDFileDownLoader()
    
    var cancellables = Set<AnyCancellable>()
    
    public func downloadFile(url: URL?, destination: URL, onStart: () -> Void, onEnd: @escaping (_ destination: URL?, _ error: CDFileDownLoaderError?) -> Void){
        
        onStart()
        
        guard let fileURL = url else {
            onEnd(nil, .inValidURL)
            return
        }
        
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
                //                            self.isDownloading = false
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
