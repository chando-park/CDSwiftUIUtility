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
import CDSheetRouter
import CDActivityView
import PDFKit



struct CDPDFViewerView: View {

    @State private var isActivityViewPresented = false
    @State var url: URL? = URL(string: "https://cdn.littlefox.co.kr/phonicsworks/pdf/PW01.pdf")!
    var body: some View {
        ZStack{
            CDPDFViewer(url: url!, name: "title", isActivityViewPresented: $isActivityViewPresented)
            Button("open sheets") {
                isActivityViewPresented = true
            }
        }
        
    }
}

struct CDPDFViewerView_Previews: PreviewProvider {
    static var previews: some View {
        @State var showPreview = false
        CDPDFViewerView()
        
    }
}
