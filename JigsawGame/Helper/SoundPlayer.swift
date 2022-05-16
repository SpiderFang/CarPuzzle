//
//  SoundPlayer.swift
//  JigsawGame
//
//  Created by Spider on 2020/8/10.
//  Copyright © 2020 SpiderWeb. All rights reserved.
//

import Foundation
import AVFoundation

class SoundPlayer {
    
    private static var player: AVAudioPlayer!
    private static var bgmPlayer: AVAudioPlayer!
    
    static func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.volume = 1.0
            player.prepareToPlay()
            player.play()
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
    
    //
    static func playBackgroundMusic(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")!
        
        do {
            bgmPlayer = try AVAudioPlayer(contentsOf: url)
            bgmPlayer.volume = 0.7
            bgmPlayer.numberOfLoops = -1
            bgmPlayer.prepareToPlay()
            bgmPlayer.play()
        }
        catch let error {
            print(error.localizedDescription)
        }
    }
}
