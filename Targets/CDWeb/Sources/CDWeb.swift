import UIKit
import SwiftUI
import WebKit

public struct CDWebview<NativeMessage:NativeFuntionList_P, Address: CDWebAddress_P>: UIViewRepresentable {
    private let address: Address
    
    public var onStarted: (() -> Void)? = nil
    public var onFinished: (() -> Void)? = nil
    public var onError: ((_ message: String?) -> Void)? = nil

    @ObservedObject var webViewCommunicator: WebViewCommunicator<NativeMessage>
    
    public init(address: Address,
                webViewCommunicator: WebViewCommunicator<NativeMessage>,
                onStarted: (() -> Void)? = nil,
                onFinished: (() -> Void)? = nil,
                onError: ((_: String?) -> Void)? = nil) {
        
        self.webViewCommunicator = webViewCommunicator
        self.address = address
        self.onStarted = onStarted
        self.onFinished = onFinished
        self.onError = onError
    }
    
    public func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.configuration.userContentController.addScriptMessages(context.coordinator, messages: webViewCommunicator.nativeMessages)
        webViewCommunicator.webView = webView
        return webView
    }
    
    public func updateUIView(_ uiView: WKWebView, context: Context) {
        if let request = address.request {
            uiView.load(request)
            print("loadHtml allHTTPHeaderFields \(String(describing: request.allHTTPHeaderFields))")
        }else{
            self.onError?("Invalid url")
        }
    }
    
    public func makeCoordinator() -> WebSlave {
        WebSlave(owner: self)
    }
    
    public class WebSlave: NSObject, WKNavigationDelegate, WKScriptMessageHandler{
        
        var owner: CDWebview
        
        public init(owner: CDWebview) {
            self.owner = owner
        }
        
        public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            self.owner.webViewCommunicator.actInNavive(message: message)
        }
        
        public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            self.owner.onStarted?()
        }
        
        public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.owner.onFinished?()
        }
        
        public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            self.owner.onError?(error.localizedDescription)
        }
    }
}
