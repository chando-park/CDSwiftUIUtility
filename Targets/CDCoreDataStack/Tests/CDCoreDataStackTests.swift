import CDWeb
import SwiftUI
import XCTest


final class CDUtilityTests: XCTestCase {
    
    enum NativeMessage: String, NativeMessageList_P, CaseIterable{
        case onInterfaceDownloadStudyGuideFile
        case onInterfaceShowPopup
        case onInterfaceMessage
    }

    enum Address: String, CDWebAddress_P, CaseIterable{
        case pdf
        var url: URL?{
            switch self {
            case .pdf:
                return URL(string: "https://apis.littlefox.com/web/guide/edu")
            }
        }
        var headers: [String : String]{
            var h = SharedHeaders.list.common
            h["api-user-agent"] = "LF_APP_iOS:phone/2.7.9/iPhone15,2/iOS:16.6"
            return h
        }
    }
    
    override func setUp() async throws {
        
    }
    
    override func tearDown() async throws {
        
    }
    
    func testComunication(){
        
        @ObservedObject var comunicator = WebViewCommunicator(nativeMessages: NativeMessage.allCases, act: { message, body, webview in
            print("message : \(message)")
        })
        
        
        CDWebview(address: Address.pdf, webViewCommunicator: comunicator)
        
        
    }
}
