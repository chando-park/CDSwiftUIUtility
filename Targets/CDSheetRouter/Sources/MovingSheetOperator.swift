//
//  MovingSheetOperator.swift
//  CDSheetRouter
//
//  Created by Littlefox iOS Developer on 2023/09/06.
//

import SwiftUI

public class MovingSheetOperator<SheetRouter:SheetRouterProtocol>: ObservableObject {
    @Published public var sheets: [SheetRouterContext<SheetRouter>] = []
    
    public init(){}
    //View의 화면 이동
    public func go(_ sheet: SheetRouter?, animation: SheetAnimation){
        if let s = sheet{
            self.sheets.append(SheetRouterContext(router: s, animation: animation))
        }
    }
    
    public func pop(){
        _ = self.sheets.popLast()
    }
}

public extension View {
    func routering<SheetRouter: SheetRouterProtocol>(_ sheets: Binding<[SheetRouterContext<SheetRouter>]>, sheetDetector: ((SheetRouter?) -> Void)? = nil) -> some View {
        modifier(MovingRoute(sheets: sheets, sheetDetector: sheetDetector))
    }
}

//extension MovingSheetOperator{
//    public func showEmailView() {
//        
//        let device_ver = UIDevice.current.systemVersion
//        let app_ver = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
//        let model: String = {
//            var systemInfo = utsname()
//            uname(&systemInfo)
//            let machineMirror = Mirror(reflecting: systemInfo.machine)
//            return machineMirror.children.reduce("") { identifier, element in
//                guard let value = element.value as? Int8, value != 0 else { return identifier }
//                return identifier + String(UnicodeScalar(UInt8(value)))
//            }
//        }()
//        let text = "Model: \(model), OS: iOS\(device_ver), Ver: LittleFox Phonics \(app_ver), NickName: \(PhcUserDefaults<String>.userNickname.value  ?? "Free User")"
//        let email = "help@littlefox.com"
//        
//        EmailService.shared.sendEmail(subject: "", body: text, to: email) { (isWorked) in
//            if !isWorked{
////                self.makeUIUtility(kind: .alert(info: AlertInfo(type: .oneBtn_confirm(actionTitle: "확인", action: nil), title: "❌", message: "사용 중인 디바이스에 메일계정등록 후 다시 시도해주세요.")))
//            }
//        }
//    }
//}
