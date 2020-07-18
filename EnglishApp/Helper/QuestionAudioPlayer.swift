//
//  QuestionAudioPlayer.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/15.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import Foundation
import AVKit

class QuestionAudioPlayer {
    
    let correctSoundPath = Bundle.main.path(forResource: "correct", ofType: "caf")
    
    let missSoundPath = Bundle.main.path(forResource: "miss", ofType: "caf")

    var correctPlayer = AVAudioPlayer()
    
    var missPlayer = AVAudioPlayer()
    
    init() {
        do {
            // 音楽と同時に効果音を出せるように
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(AVAudioSession.Category.ambient)
            try audioSession.setActive(true)
            
            correctPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: correctSoundPath!))
            missPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: missSoundPath!))
        } catch {
            print("効果音を設定できませんでした")
        }
    }
    
}

// MARK: 効果音関係
extension QuestionAudioPlayer {
    
    func playCorrectSound() {
        correctPlayer.play()
    }
    
    func playMissSound() {
        missPlayer.play()
    }
    
}
