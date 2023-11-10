//
//  SplashScreen.swift
//  FriscoTV+
//
//  Created by Blaine Beltran on 10/31/23.
//

import SwiftUI
import AVKit

struct SplashScreen: View {
    @State var player = AVPlayer(url: Bundle.main.url(forResource: "SplashScreenV2", withExtension: "mp4")!)
    var body: some View {
        VideoPlayer(player: player)
            .ignoresSafeArea()
            .allowsHitTesting(false)
            .onAppear {
                player.play()
        }
    }
}

#Preview {
    SplashScreen()
}
