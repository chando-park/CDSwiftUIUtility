# CDUtility

CDWebview는 SwiftUI에서 사용하는 UIViewRepresentable 프로토콜을 구현한 구조체로, 웹뷰를 쉽게 사용할 수 있도록 도와줍니다. URL 주소와 헤더 정보를 제공하는 프로토콜을 구현하여 사용하며, 웹페이지와 상호작용하기 위한 클래스도 제공합니다. 웹뷰의 시작과 종료, 에러 처리를 콜백으로 처리할 수 있습니다.

사용방법

import SwiftUI
import CDWebview

struct ContentView: View {
    var body: some View {
        CDWebview(address: YourWebAddress(),
                  webViewCommunicator: YourWebViewCommunicator(),
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

