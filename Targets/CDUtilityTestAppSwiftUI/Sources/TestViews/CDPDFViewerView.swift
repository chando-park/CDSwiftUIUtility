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
    
    let downLoader: CDFileDownLoader = CDFileDownLoader()

    @State private var isActivityViewPresented = false
    @State var url: URL? = URL(string: "https://www.kobaco.co.kr/site/main/file/download/uu/0c8798275ccf40d7801ec2d6c686146e.pdf")!
    @State var isProgress: Bool = false
    
    
    var body: some View {
        VStack{
//            CDPDFViewer(url: url!, name: "title", isActivityViewPresented: $isActivityViewPresented) {
//                print("onShowActivityViewst")
//                self.isProgress = true
//            } onFileDownloadEnd: { isSuccess in
//                print("onShowActivityViewEnd")
//                self.isProgress = false
//            }

            Button("open sheets") {
//                isActivityViewPresented = true
                downLoader.downloadFile(url: URL(string: "https://www.kobaco.co.kr/site/main/file/download/uu/0c8798275ccf40d7801ec2d6c686146e.pdf"), name: CDFileName.pdf("test"))
                    .receive(on: DispatchQueue.main)
                    .sink { f in
                        switch f {
                        case .finished:
                            break
                        case .failure(let failure):
                            print("down fali: \(failure)")
                            break
                        }
                    } receiveValue: { url in
                        print("comleted url \(url.absoluteString)")
                    }

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
