//
//  QuestionViewModel.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/06/30.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI
import RealmSwift

class QuestionViewModel: ObservableObject {
    
    enum Status {
        case start
        case solve
        case result
        case pause
    }
    
    var user: User = UserSetting.user
    
    var timer: Timer!

    var correctCount: Int = 0
    
    lazy var maxTime: Double = Double(questions.count * UserSetting.timePerQuestion)
    
    var maxQuestionNum: Int = UserSetting.maxQuestionNum
    
    var workbook: Workbook!
    
    let realm = try! Realm()
    
    var questions: Array<Question>!
    
    @Published var nowQuestionNum: Int = 0
    
    @Published var nowQuestion: Question!
    
    @Published var status: Status = .start
    
    @Published var remainingTime: Double!
    
    init(workbook: Workbook) {
        self.workbook = workbook
    }
    
    deinit {
        stopTimer()
    }

}

// MARK: ゲームシステム
extension QuestionViewModel {
    
    func setQuestions(workbook: Workbook) {
        guard let _questions = workbook.fetchQuestions(questionNum: maxQuestionNum) else { fatalError("questionのdataに問題があります") }
        self.questions = _questions
        
        nowQuestion = questions[nowQuestionNum]
    }
    
    func sendUserChoice(choice: String) {
        if (questions[nowQuestionNum].answer == choice) {
            correctProcess()
        } else {
            missProcess()
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
    
    func correctProcess() {
        // TODO: 正解演出
        do {
            if questions[nowQuestionNum].correctCount == 0 {
                user.totalCorrectCount += 1
            }
            user.todayCorrectCount += 1
            self.correctCount += 1
            
            try realm.write({
                questions[nowQuestionNum].correctCount += 1
            })
        } catch {
            print("failed")
        }
    }
    
    func missProcess() {
        // TODO: 不正解演出
        do {
            if questions[nowQuestionNum].missCount == 0 {
                user.totalMissCount += 1
            }
            user.todayMissCount += 1

            try realm.write({
                questions[nowQuestionNum].missCount += 1
            })
        } catch {
            print("failed")
        }
    }
    
}

// MARK: 画面遷移
extension QuestionViewModel {
    func startSolving() {
        setQuestions(workbook: workbook)
        
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

// MARK: タイマー処理
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
