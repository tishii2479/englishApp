//
//  QuestionTimerDelegate.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/01.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

class QuestionTimerDelegate: ObservableObject {
    
    private var timer: Timer!
    
    @Published var isPaused: Bool = false
    
    @Published var remainingTime: Double = 60
    
    var maxTime: Double = 60
    
    func startTimer() {
        isPaused = false
    }
    
    func pauseTimer() {
        isPaused.toggle()
    }
    
    func updateTimer(timer: Timer) {
        if isPaused { return }
        
        remainingTime -= timer.timeInterval
        
        if remainingTime <= 0 {
            stopTimer()
        }
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
    init() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: updateTimer(timer:))
        
        startTimer()
    }
    
    deinit {
        stopTimer() 
    }
    
}
