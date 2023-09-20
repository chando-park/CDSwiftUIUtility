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

enum CDPDFViewerViewRouter: SheetRouterProtocol {
    case activity(Binding<CDActivityType>)//(url: URL, title: String)
  
    @ViewBuilder func buildView(isSheeted: Binding<Bool>) -> some View {
        switch self {
        case .activity(let activities):
            CDActivityView(activityItem: activities)
        }
    }

}

class CDPDFViewerVM: PlatformOperatorVM_P{

    func received(event: MianEventKind) {
        
    }
}

struct CDPDFViewerView: View {

    @ObservedObject var router = PlatformOperator<CDPDFViewerViewRouter,CDPDFViewerVM>(viewModel: CDPDFViewerVM())
    @State var url: URL? = URL(string: "https://cdn.littlefox.co.kr/phonicsworks/pdf/PW01.pdf")!
    var body: some View {
        ZStack{
            CDPDFKitView(document: PDFDocument(url: url!)!)
            Button("open sheets") {
                CDFileDownLoader.shared.downloadFile(url: URL(string: "https://cdn.littlefox.co.kr/phonicsworks/pdf/PW01.pdf"),
                                                     name: .pdf("정답 보기")) {
                } onEnd: {  destination, error in
                    self.router.go(.activity(.constant(.url(destination!))), animation: .front(.medium))
                }
            }
        }
        
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
