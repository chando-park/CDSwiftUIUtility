//
//  WebViewCommunicator.swift
//  CDWeb
//
//  Created by Littlefox iOS Developer on 2023/08/02.
//

import WebKit

public class WebViewCommunicator<NativeMessage: NativeMessageList_P>: ObservableObject {
    
    weak var webView: WKWebView?
    let nativeMessages: [NativeMessage]
    let act: (_ nativeMessage: NativeMessage,_ body: String, _ webview: WKWebView?) -> Void

    public init(webView: WKWebView? = nil, nativeMessages: [NativeMessage], act: @escaping (_: NativeMessage, _: String, _: WKWebView?) -> Void) {
        self.webView = webView
        self.nativeMessages = nativeMessages
        self.act = act        
    }

    public func sendMessageToWeb<Fuction:JavascripFunctionList_P>(function: Fuction, param: [String]?) {
        self.webView?.callJavaScript(function: function,param: param)
    }
    
    public func addScriptMessages(_ handler: WKScriptMessageHandler){
        self.webView?.configuration.userContentController.addScriptMessages(handler, messages: self.nativeMessages)
    }
    
    public func removeScriptMessages(){
        self.webView?.configuration.userContentController.removeScriptMessages(messages: self.nativeMessages)
    }
    
    func actInNavive(message: WKScriptMessage){
        if let nm = NativeMessage(rawValue: message.name),
           let messagebody = message.body as? String{
            act(nm,messagebody,webView)
        }
        
    }    
}
