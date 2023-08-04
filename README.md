# CDUtility


## 1. CDWeb

CDWebview는 SwiftUI에서 사용하는 UIViewRepresentable 프로토콜을 구현한 구조체로, 웹뷰를 쉽게 사용할 수 있도록 도와줍니다. URL 주소와 헤더 정보를 제공하는 프로토콜을 구현하여 사용하며, 웹페이지와 상호작용하기 위한 클래스도 제공합니다. 웹뷰의 시작과 종료, 에러 처리를 콜백으로 처리할 수 있습니다.

사용방법

1. 웹뷰에서 네이티브에 전달할 메세지를 설정합니다. 해당 열거형의 이름이 메세지가 됩니다.
```
public enum NativeMessage: String, NativeMessageList_P, CaseIterable{
    case onInterfaceDownloadStudyGuideFile
    case onInterfaceShowPopup
    case onInterfaceMessage
}

- 웹에서는 아래와 같이 호출합니다.
webkit.messageHandlers.<NativeMessage의 String형태>.postMessage(<body>)
- 예시
webkit.messageHandlers.onInterfaceDownloadStudyGuideFile.postMessage(url)

- 그러면 커뮤니 케이터에서 클로저로 아래와 같이 받습니다.
- message 가 NativeMessage 형태로오게 되고 body가 url이 전달 됩니다.
@ObservedObject var comunicator = WebViewCommunicator(nativeMessages: NativeMessage.allCases, act: { message, body in
        
})
```

2. CDWebview를 사용하려면 CDWebAddress_P 프로토콜을 구현해야 합니다. 이 프로토콜은 URL과 헤더 정보를 제공합니다.
```
public enum Address: String, CDWebAddress_P, CaseIterable{
    case pdf
    
    public var url: URL?{
        switch self {
        case .pdf:
            return URL(string: "https://<주소>")
        }
    }
    
    public var headers: [String : String]{
        SharedHeaders.list.common
    }
}

```
```
struct ContentView: View {

    @ObservedObject var comunicator = WebViewCommunicator(nativeMessages: NativeMessage.allCases, act: { message, body in
        print("message : \(message)")
    })

    var body: some View {
        CDWebview(address: Address.pdf,
                  webViewCommunicator: comunicator,
                  onStarted: {
                      // WebView가 시작되었을 때 수행할 동작
                  },
                  onFinished: { webView in
                      // WebView가 로딩을 완료했을 때 수행할 동작
                  },
                  onError: { error in
                      // 에러 발생 시 수행할 동작
                  })
    }
}
```




