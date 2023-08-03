//
//  CDWeb.swift
//  CDWeb
//
//  Created by Littlefox iOS Developer on 2023/08/03.
//

import SwiftUI
import CDWeb

public enum JS_native_call_message: String, NativeFuntionList_P, CaseIterable{
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
        SharedHeaders.list.common
    }
}

struct WebTestView: View {
    @ObservedObject var comunicator = WebViewCommunicator(nativeMessages: JS_native_call_message.allCases, act: { message, body in
        print("message : \(message)")
    })
    var body: some View {
        ZStack{
            CDWebview(address: Address.pdf, webViewCommunicator: comunicator)
        }
    }
}
