import UIKit
import Combine
import AVFoundation

public class CDSound: NSObject {
    deinit {
        self.stop()
    }
    
    private var player: AVPlayer?
    private var subject = PassthroughSubject<SoundPlayStatus,Never>()
    
    private let tPlayerTracksKey = "tracks"
    private let tPlayerPlayableKey = "playable"
    private let tPlayerDurationKey = "duration"
    
    public enum SoundType {
        case mp3

        var extensionName: String{
            switch self{
            case .mp3:
                return "mp3"
            }
        }
    }

    public enum LFE_Folder: String {
        case effect = "Effect"
        
        var path: String{
            "\(self.rawValue)/"
        }
    }
    
    public enum SoundPlayError: Error{
        case cannotMakeAsset
        case cannotMakeUrl
        case innerError(error: Error)
    }
    
    public enum SoundPlayStatus{
        case playStart
        case playEnd
        case fail(error: SoundPlayError)
    }

    private func getSound(folder: LFE_Folder, soundName: String, soundType: SoundType = .mp3) -> String? {
        return Bundle.main.path(forResource: folder.path + soundName, ofType: soundType.extensionName)
        
    }
    
    private var url: URL?{
        didSet{
            guard let url = url else {
                return
            }
            self.asset = AVURLAsset(url: url)
        }
    }
    
    private var asset: AVAsset?{
        didSet{
            self.asset?.cancelLoading()
            self.setPlayer(asset: self.asset)
        }
    }
    
    private func release(){
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: nil)
        self.player = nil
    }
}

extension CDSound{
    
    public enum SoundLocationType{
        case device
        case internet
    }
    
    public func playSound(soundLocation: SoundLocationType, soundStr: String){
        
        let url: URL? = {
            switch soundLocation {
            case .device:
                if let str = self.getSound(folder: .effect, soundName: soundStr, soundType: .mp3){
                    return URL(fileURLWithPath: str)
                }else{
                    return nil
                }
            case .internet:
                return URL(string: soundStr)
            }
        }()
        
        guard let url = url else{
            self.subject.send(.fail(error: .cannotMakeUrl))
            return
        }
        
        self.url = url
    }
    
    public func stop(){
        self.player?.pause()
        self.release()
    }

    private func setPlayer(asset: AVAsset?){
        self.stop()
        
        guard let asset = asset else {
            self.subject.send(.fail(error: .cannotMakeAsset))
            return
        }
        
        let requestKeys : [String] = [tPlayerTracksKey,tPlayerPlayableKey,tPlayerDurationKey]
        asset.loadValuesAsynchronously(forKeys: requestKeys) {
            DispatchQueue.main.async {
                for key in requestKeys {
                    var error: NSError?
                    let status = asset.statusOfValue(forKey: key, error: &error)
                    
                    if status == .failed{
                        self.subject.send(.fail(error: .innerError(error: error ?? .init(domain: "unknown Error", code: -1))))
                        return
                    }
                    if asset.isPlayable == false{
                        self.subject.send(.fail(error: .innerError(error: error ?? .init(domain: "unknown Error", code: -1))))
                        return
                    }
                }
                
                let item = AVPlayerItem(asset: asset)
                self.player = AVPlayer(playerItem: item)
                self.player?.play()
                self.subject.send(.playStart)

                NotificationCenter.default.addObserver(self, selector: #selector(self.soundDidEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
            }
        }
    }
}

extension CDSound{
    @objc func soundDidEnd(){
        self.subject.send(.playEnd)
    }
}


extension CDSound{
    public func subscribe() -> AnyPublisher<SoundPlayStatus, Never>{
        self.subject.eraseToAnyPublisher()
    }
}

