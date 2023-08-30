import UIKit
import SwiftUI
import WebKit

public struct CDWebview<NativeMessage:NativeMessageList_P, Address: CDWebAddress_P>: UIViewRepresentable {

    private let address: Address
    @ObservedObject var webViewCommunicator: WebViewCommunicator<NativeMessage>
    
    public init(address: Address,
                webViewCommunicator: WebViewCommunicator<NativeMessage>) {
        
        self.webViewCommunicator = webViewCommunicator
        self.address = address

    }
    
    public func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        
        webViewCommunicator.webView = webView
        webViewCommunicator.addScriptMessages(context.coordinator)
        
        return webView
    }
    
    public func updateUIView(_ uiView: WKWebView, context: Context) {
        if let request = address.request {
            uiView.load(request)
            print("loadHtml allHTTPHeaderFields \(String(describing: request.allHTTPHeaderFields))")
        }else{
            self.webViewCommunicator.onError?(.invalidURL)
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
            self.owner.webViewCommunicator.onStarted?()
        }
        
        public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.owner.webViewCommunicator.onFinished?(webView)
        }
        
        public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            let code = (error as NSError).code
            let message = error.localizedDescription
            self.owner.webViewCommunicator.onError?(.specificError(code, message))
        }
    }
}
