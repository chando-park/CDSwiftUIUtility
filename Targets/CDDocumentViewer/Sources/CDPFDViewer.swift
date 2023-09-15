//
//  CDPFDViewer.swift
//  CDDocumentViewer
//
//  Created by Littlefox iOS Developer on 2023/09/15.
//

import SwiftUI
import UIKit
import PDFKit

public struct CDPDFKitView: UIViewRepresentable {
    let document: PDFDocument // 표시할 PDF 문서
    
    public init(document: PDFDocument) {
        self.document = document
    }

    public func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = document
        return pdfView
    }

    public func updateUIView(_ uiView: PDFView, context: Context) {
        // 뷰 업데이트가 필요한 경우 추가 코드 작성
    }
}
