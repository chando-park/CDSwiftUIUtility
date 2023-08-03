//
//  WebViewCommunicator.swift
//  CDWeb
//
//  Created by Littlefox iOS Developer on 2023/08/02.
//

import WebKit

public class WebViewCommunicator<NativeMessage: NativeFuntionList_P>: ObservableObject {
    
    weak var webView: WKWebView?
    let nativeMessages: [NativeMessage]
    let act: (_ nativeMessage: NativeMessage,_ body: String) -> Void

    public init(nativeMessages: [NativeMessage], act: @escaping (_: NativeMessage, _: String) -> Void) {
        self.nativeMessages = nativeMessages
        self.act = act
    }

    public func sendMessageToWeb<Fuction:JavascripFunctionList_P>(function: Fuction, param: [String]?) {
        self.webView?.callJavaScript(function: function,param: param)
    }
    
    func actInNavive(message: WKScriptMessage){
        if let nm = NativeMessage(rawValue: message.name),
           let messagebody = message.body as? String{
            act(nm,messagebody)
        }
        
    }    
}
