//
//  MovingSheetOperator.swift
//  CDSheetRouter
//
//  Created by Littlefox iOS Developer on 2023/09/06.
//

import SwiftUI
import CDDocumentViewer

public class MovingSheetOperator<SheetRouter:SheetRouterProtocol>: ObservableObject {
    @Published public var sheets: [SheetRouterContext<SheetRouter>] = []
    //View의 화면 이동
    public func go(_ sheet: SheetRouter?, animation: SheetAnimation){
        if let s = sheet{
            self.sheets.append(SheetRouterContext(router: s, animation: animation))
        }
    }
    
    public func openPDF(urlStr: String, title: String, detecter: ((DocumentDownload.LoadStatus) -> Void)? = nil){
        let window = UIApplication.shared.keyWindow
        if let parent = window?.rootViewController{
            let d = DocumentDownload(presenter: parent, statusDetecter: detecter)
            d.opnePDF(urlStr: urlStr, title: title)
        }
        
    }
}

public extension View {
    func routering<SheetRouter: SheetRouterProtocol>(_ sheets: Binding<[SheetRouterContext<SheetRouter>]>, sheetDetector: ((SheetRouter?) -> Void)? = nil) -> some View {
        modifier(MovingRoute(sheets: sheets, sheetDetector: sheetDetector))
    }
}
