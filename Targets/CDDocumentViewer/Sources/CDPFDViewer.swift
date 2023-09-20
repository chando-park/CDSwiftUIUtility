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

public struct CDPDFViewer: View{
    
    let url: URL
    let name: String
    @Binding var isActivityViewPresented: Bool
    @State var isLoadCompleted: Bool = false
    @State var destination: URL? = nil
    
    public init(url: URL, name: String, isActivityViewPresented: Binding<Bool>) {
        self.url = url
        self.name = name
        self._isActivityViewPresented = isActivityViewPresented
    }

    var body: some View{
        CDPDFKitView(document: PDFDocument(url: url)!)
            .background(
                isLoadCompleted == false ?
                  CDActivityView(
                    isPresented: .constant(false),
                    activityItmes: []
                  )
                :
                    CDActivityView(
                      isPresented: $isActivityViewPresented,
                      activityItmes: [.url(self.destination!)]
                    )
                )
            .onAppear {
                if isLoadCompleted == false{
                    self.openPDFActivitySheet(url: url, name: name)
                }
            }
    }
    
    func openPDFActivitySheet(url: URL?, name: String){
        CDFileDownLoader.shared.downloadFile(url: url,name: .pdf(name)) {
            
        } onEnd: {  destination, error in
            if let destination = destination{
                self.isLoadCompleted = true
                self.destination = destination
            }
        }
    }
}
