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
    
    var user: User = User.shared
    
    var timer: Timer!

    var correctCount: Int = 0
    
    lazy var maxTime: Double = Double(questions.count * user.timePerQuestion)
    
    lazy var maxQuestionNum: Int = user.maxQuestionNum
    
    var workbook: Workbook!
    
    let realm = try! Realm()
    
    var questions: Array<Question>!
    
    private let effectDuration: Double = 0.2
    
    @Published var nowQuestionNum: Int = 0
    
    @Published var nowQuestion: Question!
    
    @Published var status: Status = .start
    
    @Published var remainingTime: Double!
    
    @Published var backgroundColor: Color = .clear
    
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
        if questions[nowQuestionNum].answer == choice {
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
    
    // TODO: それぞれの状態に応じてRealmの更新を考える必要があり
    func correctProcess() {
        correctEffect()
        
        user.incrementCorrectCount()
        correctCount += 1
        
        // 初めて正解した時
        if nowQuestion.correctCount == 0 {
            workbook.updateCount(type: .correct, amount: 1)
            
            // 一度間違えたことがある問題であった場合
            if nowQuestion.missCount > 0  {
                workbook.updateCount(type: .miss, amount: -1)
            }
        }
        
        // これは最後に書かないとworkbookの更新がうまくいかない
        nowQuestion.updateCount(type: .correct, amount: 1)
    }
    
    // TODO: それぞれの状態に応じてRealmの更新を考える必要があり
    func missProcess() {
        missEffect()
        
        user.incrementMissCount()
        
        // 初めて不正解した時
        if nowQuestion.missCount == 0 {
            workbook.updateCount(type: .miss, amount: 1)
        }
        
        // これは最後に書かないとworkbookの更新がうまくいかない
        nowQuestion.updateCount(type: .miss, amount: 1)
    }
    
}

// MARK: エフェクト
extension QuestionViewModel {
    
    func correctEffect() {
        backgroundColor = .offBlue
        
        DispatchQueue.main.asyncAfter(deadline: .now() + effectDuration, execute: {
            self.backgroundColor = .clear
        })
    }
    
    func missEffect() {
        backgroundColor = .offRed
        
        DispatchQueue.main.asyncAfter(deadline: .now() + effectDuration, execute: {
            self.backgroundColor = .clear
        })
    }
    
}

// MARK: 画面遷移
extension QuestionViewModel {
    func startSolving() {
        setQuestions(workbook: workbook)
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: updateTimer(timer:))
        remainingTime = maxTime
        nowQuestionNum = 0
        correctCount = 0
        
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
