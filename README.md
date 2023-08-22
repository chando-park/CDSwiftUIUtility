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

## 2. CDRouter
# Coordinator.swift

Swift 코드를 활용한 시트 라우팅과 관련된 파일입니다.

## 목차

## 소개

이 Swift 파일은 SwiftUI 애플리케이션에서 시트 라우팅을 처리하기 위한 구조와 프로토콜을 정의합니다.

## 열거형

### SheetAnimation

다양한 종류의 시트 애니메이션을 나타내는 열거형입니다.

- `none`: 애니메이션이 없습니다.
- `full`: 전체 화면 애니메이션.
- `front`: 전면 애니메이션.
- `push`: 푸시 애니메이션.

## 프로토콜

### SheetRouterProtocol

시트 라우터를 나타내는 프로토콜입니다.

- 연관 타입: `Sheet` (SwiftUI의 `View`).
- 함수: `buildView(isSheeted:) -> Sheet` - 라우터와 연관된 뷰를 생성합니다.

### Equatable 준수

이 프로토콜은 `id` 속성을 기반으로 `Equatable` 프로토콜을 준수합니다.

## 구조체

### SheetRouterContext

시트 라우터의 컨텍스트를 나타내는 구조체입니다.

- 속성:
  - `router`: `SheetRouterProtocol`을 준수하는 인스턴스.
  - `animation`: 애니메이션 유형을 나타내는 `SheetAnimation`.

## 수식어

### Routering

시트 라우팅을 처리하는 SwiftUI 뷰 수식어입니다.

- 속성:
  - `sheets`: `SheetRouterContext`의 배열에 대한 바인딩.

- 계산된 속성:
  - `isActiveBinding`: 활성화된 시트가 있는지 나타내는 바인딩.
  - `isPusheSheeted`: 푸시 시트가 활성화되었는지 나타내는 바인딩.
  - `isFullSheeted`: 전체 시트가 활성화되었는지 나타내는 바인딩.
  - `isFrontSheeted`: 전면 시트가 활성화되었는지 나타내는 바인딩.

- 내용:
  - 활성화된 시트가 없으면 내용을 직접 표시합니다.
  - 그렇지 않은 경우 SwiftUI의 수식어를 사용하여 애니메이션 유형에 따라 시트를 표시합니다.

### View 확장

`View` 유형에 `routering` 함수를 추가하는 확장입니다.

- 함수: `routering<SheetRouter: SheetRouterProtocol>(_ sheets:) -> some View` - 뷰에 `Routering` 수식어를 적용합니다.

## 클래스

### SheetRouterOperator

ObservableObject 패턴을 사용하는 시트 라우터 연산자를 나타내는 클래스입니다.

- 속성:
  - `sheets`: Observable 배열인 `SheetRouterContext`.

- 함수:
  - `go(_:animation:)`: `sheets` 배열에 시트 컨텍스트를 추가합니다.

---



