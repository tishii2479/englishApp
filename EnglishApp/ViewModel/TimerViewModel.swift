//
//  TimerViewModel.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/08/20.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import Foundation

class TimerViewModel : ObservableObject {
    
    var timer : Timer!
    
    @Published var count = 0
    
    @Published var maxCount = 60
    
    func start() {
        print("start")
        self.timer?.invalidate()
        self.count = 0
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: updateTimer(timer:))
    }
    
    func updateTimer(timer: Timer) {
        print(self.count)
        self.count += 1
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
}
