//
//  DocumentDownloader.swift
//  CDUtilityTestAppSwiftUI
//
//  Created by Littlefox iOS Developer on 2023/09/14.
//

import UIKit
import SwiftUI
import CDFileDownLoader

public struct CDDocumentViewer: UIViewControllerRepresentable {
    private var url: Binding<URL?>
    private var isActive: Binding<Bool>
    private let viewController = UIViewController()
    private let docController: UIDocumentInteractionController
    
    public init(_ isActive: Binding<Bool>, url: Binding<URL?> , title: String) {
        self.isActive = isActive
        self.url = url
        self.docController = UIDocumentInteractionController()
        self.docController.name = title
    }
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<CDDocumentViewer>) -> UIViewController {
        
        docController.delegate = context.coordinator
        //URL(string: "https://cdn.littlefox.co.kr/phonicsworks/pdf/PW01.pdf")
        let destinationURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("downloadedFile.pdf")
        CDFileDownLoader.shared.downloadFile(url: url.wrappedValue, destination: destinationURL) {
            
        } onEnd: { destination, error in
            
            if let destination = destination{
                self.docController.url = destination
                self.docController.presentPreview(animated: false)
            }
        }
        viewController.view.backgroundColor = .clear
        return viewController
    }
    
    public func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<CDDocumentViewer>) {
        
        
        
    }
    
    public func makeCoordinator() -> Coordintor {
        return Coordintor(owner: self)
    }
    
    public final class Coordintor: NSObject, UIDocumentInteractionControllerDelegate { // works as delegate
        let owner: CDDocumentViewer
        init(owner: CDDocumentViewer) {
            self.owner = owner
        }
        public func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
            return owner.viewController
        }
        
        public func documentInteractionControllerDidEndPreview(_ controller: UIDocumentInteractionController) {
            controller.delegate = nil // done, so unlink self
            owner.isActive.wrappedValue = false // notify external about done
        }
    }
}
