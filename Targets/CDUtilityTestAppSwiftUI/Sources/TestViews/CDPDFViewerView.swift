//
//  CDPDFViewerView.swift
//  CDUtility
//
//  Created by Littlefox iOS Developer on 2023/09/13.
//

import SwiftUI
import PDFKit
import CDDocumentViewer
import CDFileDownLoader
import PDFKit

struct CDPDFViewerView: View {
//    @Binding var isShowPreview: Bool
    @State var isLoading: Bool = false
    @State var url: URL = URL(string: "https://cdn.littlefox.co.kr/phonicsworks/pdf/PW01.pdf")!
    var body: some View {
        //CDDocumentViewer($isShowPreview, url: $url, title: "title")
        CDPDFKitView(document: PDFDocument(url: url)!)
    }
}

struct CDPDFViewerView_Previews: PreviewProvider {
    static var previews: some View {
        @State var showPreview = false
        NavigationView {
            CDPDFViewerView()
        }
        
    }
}
