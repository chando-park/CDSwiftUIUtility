//
//  SoundView.swift
//  CDUtilityTestAppSwiftUI
//
//  Created by Littlefox iOS Developer on 11/29/23.
//

import SwiftUI
import CDSound
import Combine
import CDOrientation

struct SoundView: View {
    
    let soundPlayer = CDSound()
    @State var cancellables = Set<AnyCancellable>()
    
    var body: some View {
        List {
            Section {
                Button("play") {
                    soundPlayer.playSound(soundLocation: .internet, soundStr: "https://cdn.littlefox.co.kr/contents/quiz/data/C0005738/4d85d8fd550b527db7e905eed2717923.mp3?1365148976")
                        .sink { status in
                            print("status \(status)")
                        }
                        .store(in: &cancellables)
                }
                
            }
        }
    }
}

#Preview {
    SoundView()
}
