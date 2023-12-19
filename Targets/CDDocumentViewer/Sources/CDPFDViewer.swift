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
    let type: PDFDisplayMode
    
//    public init(documentURL: Binding<URL?>) {
//        self._documentURL = documentURL
//    }
    
    public init(documentURL: Binding<URL?>, type: PDFDisplayMode) {
        self._documentURL = documentURL
        self.type = type
    }

    public func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        pdfView.displayMode = type
        return pdfView
    }

    public func updateUIView(_ uiView: PDFView, context: Context) {
        if let documentURL = documentURL {
            uiView.document = PDFDocument(url: documentURL)
        }
        
    }
}
