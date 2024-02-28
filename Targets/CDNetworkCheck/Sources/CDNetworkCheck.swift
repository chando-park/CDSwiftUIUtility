//
//  CDActivityType.swift
//  CDActivityView
//
//  Created by Littlefox iOS Developer on 2023/09/19.
//

import Network
import Combine

public class CDNetworkStatusChecker {

    // 네트워크 상태 타입 정의
    public enum NetworkStatus {
        case wifi
        case cellular
        case notConnected
    }
    
    private let monitor: NWPathMonitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    
    public init() {}
    
    // 네트워크 상태를 확인하는 Publisher 생성 메소드
    public func networkStatusPublisher() -> AnyPublisher<NetworkStatus, Never> {
        Future<NetworkStatus, Never> { promise in
            self.monitor.pathUpdateHandler = { path in
                let status: NetworkStatus
                
                if path.status == .satisfied {
                    if path.isExpensive {
                        status = .cellular
                    } else {
                        status = .wifi
                    }
                } else {
                    status = .notConnected
                }
                
                promise(.success(status))
                
                // 네트워크 상태 확인 후 모니터링 중단
                self.monitor.cancel()
            }
            
            self.monitor.start(queue: self.queue)
        }
        .handleEvents(receiveCancel: {
            self.monitor.cancel()
        })
//        .receive(on: Di.main)
        .eraseToAnyPublisher()
    }
}
