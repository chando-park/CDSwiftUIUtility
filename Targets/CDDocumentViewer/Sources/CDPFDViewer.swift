//
//  CDPFDViewer.swift
//  CDDocumentViewer
//
//  Created by Littlefox iOS Developer on 2023/09/15.
//

import SwiftUI
import UIKit
import PDFKit
import CDActivityView
import CDFileDownLoader

public struct CDPDFKitView: UIViewRepresentable {
    @Binding var documentURL: URL? // 표시할 PDF 문서
    
    public init(documentURL: Binding<URL?>) {
        self._documentURL = documentURL
    }

    public func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        return pdfView
    }

    public func updateUIView(_ uiView: PDFView, context: Context) {
        if let documentURL = documentURL {
            uiView.document = PDFDocument(url: documentURL)
        }
        
    }
}

public struct CDPDFViewer: View{
    
    var url: URL
    let name: String
    @Binding var isActivityViewPresented: Bool
    @State var isLoadCompleted: Bool = false
    @State var destination: URL? = nil
    
    var onFileDownloadStart: (() -> Void)?
    var onFileDownloadEnd: ((_ isSuccess: Bool) -> Void)?
    
    public init(url: URL, name: String, isActivityViewPresented: Binding<Bool>, onFileDownloadStart: (() -> Void)? = nil, onFileDownloadEnd: ((_ isSuccess: Bool) -> Void)? = nil) {
        self.url = url
        self.name = name
        self.onFileDownloadStart = onFileDownloadStart
        self.onFileDownloadEnd = onFileDownloadEnd
        self._isActivityViewPresented = isActivityViewPresented
    }

    public var body: some View{
        ZStack{
            CDPDFKitView(documentURL: $destination)
                .background(
                    isLoadCompleted == false ?
                    CDActivityView(isPresented: .constant(false), activityItmes: []) :
                    CDActivityView(isPresented: $isActivityViewPresented,activityItmes: [.url(self.destination!)])
                )
                .onAppear {
                    if isLoadCompleted == false{
                        self.openPDFActivitySheet(url: url, name: name)
                    }
                }
        }
        
    }
    
    func openPDFActivitySheet(url: URL?, name: String){
        CDFileDownLoader.shared.downloadFile(url: url,name: .pdf(name)) {
            onFileDownloadStart?()
        } onEnd: {  destination, error in
            if let destination = destination{
                self.isLoadCompleted = true
                self.destination = destination
                onFileDownloadEnd?(true)
            }else{
                onFileDownloadEnd?(false)
            }
            
        }
    }
}
