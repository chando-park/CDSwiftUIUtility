//
//  WebViewCommunicator.swift
//  CDWeb
//
//  Created by Littlefox iOS Developer on 2023/08/02.
//

import WebKit

public class WebViewCommunicator<NativeMessage: NativeMessageList_P>: ObservableObject {
    
    weak var webView: WKWebView?
    let nativeMessages: [NativeMessage]?
    let act: (_ nativeMessage: NativeMessage,_ body: Any, _ webview: WKWebView?) -> Void
    
    var onStarted: (() -> Void)? = nil
    var onFinished: ((_ webView: WKWebView) -> Void)? = nil
    var onError: ((_ message: CDWebError?) -> Void)? = nil

    public init(webView: WKWebView? = nil,
                nativeMessages: [NativeMessage]?,
                act: @escaping (_: NativeMessage, _: Any, _: WKWebView?) -> Void,
                onStarted: (() -> Void)? = nil,
                onFinished: ((_: WKWebView) -> Void)? = nil,
                onError: ((_: CDWebError?) -> Void)? = nil) {
        self.webView = webView
        self.nativeMessages = nativeMessages
        self.act = act
        self.onStarted = onStarted
        self.onFinished = onFinished
        self.onError = onError
    }

    public func sendMessageToWeb<Fuction:JavascripFunctionList_P>(function: Fuction, param: [String]?) {
        self.webView?.callJavaScript(function: function,param: param)
    }
    
    public func addScriptMessages(_ handler: WKScriptMessageHandler){
        if let nativeMessages = nativeMessages{
            self.webView?.configuration.userContentController.addScriptMessages(handler, messages: nativeMessages)
        }
        
    }
    
    public func removeScriptMessages(){
        if let nativeMessages = nativeMessages{
            self.webView?.configuration.userContentController.removeScriptMessages(messages: nativeMessages)
        }
    }
    
    func actInNavive(message: WKScriptMessage){
        if let nm = NativeMessage(rawValue: message.name){
//           let messagebody = message.body {
            act(nm, message.body ,webView)
        }
        
    }    
}
