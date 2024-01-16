//
//  CDPFDViewer.swift
//  CDDocumentViewer
//
//  Created by Littlefox iOS Developer on 2023/09/15.
//

import SwiftUI
import UIKit
import PDFKit
//import CDActivityView
import CDFileDownLoader


public struct CDPDFKitView: UIViewRepresentable {
    let documentURL: URL? // 표시할 PDF 문서
    let type: PDFDisplayMode
    
//    public init(documentURL: Binding<URL?>) {
//        self._documentURL = documentURL
//    }
    
    public init(documentURL: URL, type: PDFDisplayMode) {
        self.documentURL = documentURL
        self.type = type
    }

    public func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        pdfView.displayMode = type
        
        if let documentURL = documentURL {
            pdfView.document = PDFDocument(url: documentURL)
        }
        
        return pdfView
    }

    public func updateUIView(_ uiView: PDFView, context: Context) {
        
        
    }
}
