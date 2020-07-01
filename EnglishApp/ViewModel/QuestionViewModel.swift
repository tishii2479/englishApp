//
//  QuestionViewModel.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/06/30.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

class QuestionViewModel: ObservableObject {
    
    enum Status {
        case start
        case solve
        case result
        case pause
    }
    
    private var questions: Array<Question> = [
        Question(questionText: "QuestionText1", answer: "Answer", choices: ["Answer", "B", "C", "D"]),
        Question(questionText: "QuestionText2", answer: "Answer", choices: ["Answer", "C", "C", "D"]),
        Question(questionText: "QuestionText3", answer: "Answer", choices: ["Answer", "D", "C", "D"]),
    ]
    
    
    var timer: Timer!
     
    var maxTime: Double = 60
    
    var maxQuestionNum: Int = 3
    
    var correctCount: Int = 2
    
    @Published var nowQuestionNum: Int = 0
    
    @Published var nowQuestion: Question!
    
    @Published var status: Status = .start
    
    @Published var remainingTime: Double = 60
    
    init() {
        nowQuestion = questions[nowQuestionNum]
    }
    
    deinit {
        stopTimer()
    }
    
    func sendUserChoice(choice: String) {
        goToNextQuestion()
    }
    
    // 次の問題があればnowQuestionNumをインクリメント、なければリザルト画面へ遷移
    func goToNextQuestion() {
        if nowQuestionNum < maxQuestionNum - 1 {
            nowQuestionNum += 1
            nowQuestion = questions[nowQuestionNum]
        } else {
            endSolving()
        }
    }
    
    func startSolving() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: updateTimer(timer:))
        remainingTime = maxTime
        nowQuestionNum = 0
        
        status = .solve
    }
    
    func pauseSolving() {
        status = .pause
    }
    
    func resumeSolving() {
        status = .solve
    }
    
    func endSolving() {
        stopTimer()
        
        status = .result
    }
    
    func quitSolving() {
        stopTimer()
        
        status = .start
    }
    
}

// タイマー
extension QuestionViewModel {
    
    func updateTimer(timer: Timer) {
        if status != .solve { return }
        
        remainingTime -= timer.timeInterval
        
        if remainingTime <= 0 {
            endSolving()
        }
    }
    
    func stopTimer() {
        timer.invalidate()
    }

}
