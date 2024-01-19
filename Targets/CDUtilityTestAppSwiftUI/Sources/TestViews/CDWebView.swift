//
//  CDWeb.swift
//  CDWeb
//
//  Created by Littlefox iOS Developer on 2023/08/03.
//

import SwiftUI
import CDWeb

public enum NativeMessage: String, NativeMessageList_P, CaseIterable{
    case onInterfaceDownloadStudyGuideFile
    case onInterfaceShowPopup
    case onInterfaceMessage
}

public enum Address: String, CDWebAddress_P, CaseIterable{
    case pdf
    
    public var url: URL?{
        switch self {
        case .pdf:
            return URL(string: "https://apis.littlefox.com/web/guide/edu")
        }
    }
    
    public var headers: [String : String]{
        var h = SharedHeaders.list.common
        h["api-user-agent"] = "LF_APP_iOS:phone/2.7.9/iPhone15,2/iOS:16.6"
        return h
    }
}

struct WebTestView: View {
    @State var isResuest: Bool = false
    @ObservedObject var comunicator = WebViewCommunicator(nativeMessages: NativeMessage.allCases, act: { message, body, webview in
        print("message : \(message)")
    })
    var body: some View {
        ZStack{
            CDWebview(address: Address.pdf, backgrouneColor: .white, isRequest: $isResuest, webViewCommunicator: comunicator)
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                self.isResuest = true
            }
        })
    }
}
