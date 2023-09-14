//
//  DocumentDownloader.swift
//  CDUtilityTestAppSwiftUI
//
//  Created by Littlefox iOS Developer on 2023/09/14.
//

import UIKit


public class DocumentDownload: NSObject{
    
    public enum LoadStatus{
        case start
        case ing
        case end(isSuccess: Bool, errorMessage: String?)
    }
    public typealias DocumentDownloadStatusCloser = (LoadStatus)->()
    public var statusDetecter: DocumentDownloadStatusCloser?
    
    deinit{
        print("deinit \(self)")
    }
    
    let documentInteractionController: UIDocumentInteractionController
    var canOpenPDF: Bool = true
    
    unowned let presenter: UIViewController
    private var _task: URLSessionDataTask?
    
    public init(presenter: UIViewController, statusDetecter: DocumentDownloadStatusCloser? = nil) {
        self.presenter = presenter
        self.documentInteractionController = UIDocumentInteractionController()
        self.statusDetecter = statusDetecter
        super.init()
        self.documentInteractionController.delegate = self
    }
    
    public func opnePDF(urlStr: String?, title: String){
        
        guard self.canOpenPDF else {
            return
        }
        
        if let s = urlStr{
            if #available(iOS 10.0, *) {
//                self.canOpenPDF = false
                self.storeAndShare(withURLString: s, title: title)
            } else {
                UIApplication.shared.openURL(URL(string: s)!)
            }
        }else{
            print("pdf url incorrected")
        }
    }
    
    
    private func share(url: URL, title: String) {
        self.documentInteractionController.url = url
        self.documentInteractionController.uti = url.typeIdentifier ?? "public.data, public.content"
        self.documentInteractionController.name = title//AppConfig.laguage.study_guide
        self.documentInteractionController.presentPreview(animated: true)
    }
    
    
    private func storeAndShare(withURLString: String, title: String) {
        self.statusDetecter?(.start)
        guard let url = URL(string: withURLString) else {
            return
        }
        
        self._task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            self.statusDetecter?(.ing)
            
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.statusDetecter?(.end(isSuccess: false, errorMessage: error?.localizedDescription))
                }
                return
            }
            
            let tmpURL = FileManager.default.temporaryDirectory.appendingPathComponent(response?.suggestedFilename ?? "fileName.png")
            do {
                try data.write(to: tmpURL)
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.statusDetecter?(.end(isSuccess: false, errorMessage: error.localizedDescription))
                }
            }
            DispatchQueue.main.async {
                self.share(url: tmpURL, title: title)
                self.statusDetecter?(.end(isSuccess: true, errorMessage: nil))
            }
        }//.resume()
        self._task?.resume()
    }
    
    func cancel(){
        print("cancel download")
         self._task?.cancel()
    }
}

extension DocumentDownload: UIDocumentInteractionControllerDelegate {
    public func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        self.presenter

    }
}

extension URL {
    public var typeIdentifier: String? {
        return (try? resourceValues(forKeys: [.typeIdentifierKey]))?.typeIdentifier
    }
    public var localizedName: String? {
        return (try? resourceValues(forKeys: [.localizedNameKey]))?.localizedName
    }
}
