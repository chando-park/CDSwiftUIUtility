//
//  SoundView.swift
//  CDUtilityTestAppSwiftUI
//
//  Created by Littlefox iOS Developer on 11/29/23.
//

import SwiftUI
import CDSound
import Combine

struct SoundView: View {
    
    let soundPlayer = CDSound()
    @State var cancellables = Set<AnyCancellable>()
    
    var body: some View {
        List {
            Section {
                Button("play") {
//                    router.go(.fullsheet, animation: .full(animationOn: false))
                    soundPlayer.playSound(soundLocation: .internet, soundStr: "https://cdn.littlefox.co.kr/contents/quiz/data/C0005738/4d85d8fd550b527db7e905eed2717923.mp3?1365148976")
                }
                
            }
        }
        .onAppear(perform: {
            soundPlayer.subscribe()
                .sink { status in
                    print("status \(status)")
                    //https://cdn.littlefox.co.kr/contents/quiz/data/C0005738/4d85d8fd550b527db7e905eed2717923.mp3?1365148976
                }
                .store(in: &cancellables)
        })
        
    }
}

#Preview {
    SoundView()
}
