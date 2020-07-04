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
    
    private var questions: Array<Question>!
    
    var timer: Timer!

    var correctCount: Int = 0
    
    lazy var maxTime: Double = Double(questions.count * UserSetting.timePerQuestion)
    
    lazy var maxQuestionNum: Int = questions.count
    
    private var workbookId: String!
    
    private var questionDecoder: QuestionDecoder = QuestionDecoder()
    
    @Published var nowQuestionNum: Int = 0
    
    @Published var nowQuestion: Question!
    
    @Published var status: Status = .start
    
    @Published var remainingTime: Double!
    
    init(workbookId: String) {
        setQuestions(workbookId: workbookId)
        remainingTime = maxTime
    }
    
    deinit {
        stopTimer()
    }
    
    func setQuestions(workbookId: String) {
        self.workbookId = workbookId
        guard let _questions = questionDecoder.fetchQuestionFromWorkbookId(workbookId: workbookId) else { fatalError("question were not able to fetch") }
        self.questions = _questions
        
        nowQuestion = questions[nowQuestionNum]
    }
    
    func sendUserChoice(choice: String) {
        if (questions[nowQuestionNum].answer == choice) {
            correctCount += 1
            // TODO: 正解演出
            print("正解")
        } else {
            // TODO: 不正解演出
            print("不正解")
        }
        
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
        guard let _ = timer else { return }
        
        timer.invalidate()
    }

}
