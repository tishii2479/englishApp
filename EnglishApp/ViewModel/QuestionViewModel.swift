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
    
    var solveMode: SolveMode = .onlyNew
    
    var finishSolving: Bool = false
    
    var user: User = User.shared
    
    var timer: Timer!

    var correctCount: Int = 0
    
    var maxTime: Double = Double(User.shared.timePerQuestion)
    
    var totalTime: Double = 0
    
    var maxQuestionNum: Int = User.shared.maxQuestionNum
    
    var workbook: Workbook!
    
    let realm = try! Realm()
    
    var questions: Array<Question>!
    
    var userChoices: Array<String> = Array<String>()
    
    private let effectDuration: Double = 0.2
    
    @Published var nowQuestionNum: Int = 0
    
    @Published var nowQuestion: Question!
    
    @Published var status: Status = .start
    
    @Published var remainingTime: Double!
    
    @Published var backgroundColor: Color = .clear
    
    @Published var progressBarColor: Color = Color.offWhite
    
    init(workbook: Workbook, solveMode: SolveMode) {
        self.workbook = workbook
        self.solveMode = solveMode
    }
    
    deinit {
        stopTimer()
    }

}

// MARK: ゲームシステム
extension QuestionViewModel {
    
    func questionExist() {
        
    }
    
    func fetchQuestions() {
        guard let _questions = workbook.fetchQuestions(questionNum: maxQuestionNum, solveMode: self.solveMode) else { fatalError("questionのdataに問題があります") }

        questions = _questions
    }
    
    func sendUserChoice(choice: String) {
        if (finishSolving) { return }
        
        userChoices.append(choice)
            
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
            remainingTime = maxTime
            progressBarColor = Color.offWhite
            
        } else {
            
            self.finishSolving = true
            timer.invalidate()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + effectDuration + 0.3){
                self.endSolving()
            }
        }
    }
    
    // TODO: それぞれの状態に応じてRealmの更新を考える必要があり
    func correctProcess() {
        correctEffect()
        
        correctCount += 1
        
        // 初めて正解した時
        if nowQuestion.correctCount == 0 {
            workbook.updateCount(type: .correct, amount: 1)
            user.incrementCorrectCount()
            
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
        
        // 初めて不正解した時
        if nowQuestion.missCount == 0 {
            user.incrementMissCount()
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
        fetchQuestions()
        
        nowQuestionNum = 0
        nowQuestion = questions[nowQuestionNum]
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: updateTimer(timer:))
        maxQuestionNum = user.maxQuestionNum
        maxTime = Double(user.timePerQuestion)
        remainingTime = maxTime
        correctCount = 0
        totalTime = 0
        progressBarColor = Color.offWhite
        userChoices.removeAll()
        finishSolving = false
        
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
        totalTime += timer.timeInterval
        
        // TODO: 色の変わり方を場所によって計算して変更する
        if remainingTime < maxTime / 5 {
            progressBarColor = Color.red
        } else if remainingTime < maxTime / 2 {
            progressBarColor = Color.offRed
        }
        
        // TODO: モードによって変える
        if remainingTime <= 0 {
            endSolving()
        }
    }
    
    func stopTimer() {
        guard let _ = timer else { return }
        
        timer.invalidate()
    }

}
