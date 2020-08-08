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
        case back   // 問題集画面に戻るとき
        case idle   // 問題の正解不正解演出中
    }
    
    var solveMode: SolveMode = .onlyNew
    
    var user: User = User.shared
    
    var timer: Timer!

    var correctCount: Int = 0
    
    var maxTime: Double = Double(User.shared.timePerQuestion)
    
    var totalTime: Double = 0
    
    var maxQuestionNum: Int = User.shared.maxQuestionNum
    
    var workbook: Workbook!
    
    var category: Category!
    
    let realm = try! Realm()
    
    var questions: Array<Question>!
    
    var userChoices: Array<String> = Array<String>()
    
    private let effectDuration: Double = 0.2
    
    private let audioPlayer: QuestionAudioPlayer = QuestionAudioPlayer()
    
    @Published var nowQuestionNum: Int = 0
    
    @Published var nowQuestion: Question!
    
    @Published var status: Status = .start
    
    @Published var remainingTime: Double!
    
    @Published var backgroundColor: Color = .clear
    
    @Published var progressBarColor: Color = Color.offWhite
    
    @Published var progressBarDownerShadowColor: Color = Color.black.opacity(0.2)
    
    @Published var progressBarUpperShadowColor: Color = Color.white.opacity(0.7)
    
    @Published var showCorrectCircle: Bool = false
    
    @Published var showMissCross: Bool = false
    
    init(category: Category, workbook: Workbook, solveMode: SolveMode) {
        print("init \(workbook.title), \(solveMode)")
        self.category = category
        self.workbook = workbook
        self.solveMode = solveMode
    }
    
    deinit {
        stopTimer()
    }

}

// MARK: ゲームシステム
extension QuestionViewModel {
    
    func fetchQuestions(workbook: Workbook, maxQuestionNum: Int, solveMode: SolveMode) -> Array<Question> {
        guard let _questions = workbook.fetchQuestions(questionNum: maxQuestionNum, solveMode: solveMode) else { fatalError("questionのdataに問題があります") }

        guard _questions.count > 0 else { fatalError("questionの数が足りていません") }
        
        return _questions
    }
    
    func sendUserChoice(choice: String) {
        if status == .idle { return }
        
        userChoices.append(choice)
            
        if questions[nowQuestionNum].answer == choice {
            correctProcess()
        } else {
            missProcess()
        }

        status = .idle
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: {
            self.goToNextQuestion()
        })
    }
    
    // 次の問題があればnowQuestionNumをインクリメント、なければリザルト画面へ遷移
    func goToNextQuestion() {
        showMissCross = false
        showCorrectCircle = false
        resetProgressBarColor()
        
        if nowQuestionNum < maxQuestionNum - 1 {
            nowQuestionNum += 1
            nowQuestion = questions[nowQuestionNum]
            remainingTime = maxTime
            
            status = .solve
        } else {
            timer.invalidate()
            self.endSolving()
        }
    }
    
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
            
            category.incrementCorrectCount()
        }
        
        // これは最後に書かないとworkbookの更新がうまくいかない
        nowQuestion.updateCount(type: .correct, amount: 1)
    }
    
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
    
    func checkClearOfWorkbook(solveMode: SolveMode, maxQuestionNum: Int, correctCount: Int, workbook: Workbook) {
        let firstClear: Bool = solveMode == .test && maxQuestionNum == correctCount && workbook.isCleared == false
        
        if firstClear {
            workbook.setCleared(isCleared: true)
            user.incrementClearCount()
        }
    }
    
}

// MARK: エフェクト
extension QuestionViewModel {
    
    func correctEffect() {
//        backgroundColor = .offBlue
        audioPlayer.playCorrectSound()
        showCorrectCircle = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + effectDuration, execute: {
            self.backgroundColor = .clear
        })
    }
    
    func missEffect() {
//        backgroundColor = .offRed
        audioPlayer.playMissSound()
        showMissCross = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + effectDuration, execute: {
            self.backgroundColor = .clear
        })
    }
    
    func resetProgressBarColor() {
        progressBarDownerShadowColor = Color.black.opacity(0.2)
        progressBarUpperShadowColor = Color.white.opacity(0.7)
        progressBarColor = Color.offWhite
    }
    
    func updateProgressBarColor() {
        if remainingTime < maxTime / 5 {
            progressBarColor = Color.darkRed
            progressBarUpperShadowColor = Color.offWhite
            progressBarDownerShadowColor = Color.darkRed
        } else if remainingTime < maxTime / 2 {
            progressBarColor = Color.offRed
            progressBarUpperShadowColor = Color.offWhite
            progressBarDownerShadowColor = Color.offRed
        }
    }
    
}

// MARK: 画面遷移
extension QuestionViewModel {
    
    func startSolving() {
        print("start Solving")
        questions = fetchQuestions(workbook: self.workbook, maxQuestionNum: self.maxQuestionNum, solveMode: self.solveMode)
        
        nowQuestionNum = 0
        nowQuestion = questions[nowQuestionNum]
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: updateTimer(timer:))
        maxQuestionNum = questions.count
        maxTime = Double(user.timePerQuestion)
        remainingTime = maxTime
        correctCount = 0
        totalTime = 0
        progressBarColor = Color.offWhite
        userChoices.removeAll()
        
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
        checkClearOfWorkbook(solveMode: self.solveMode, maxQuestionNum: self.maxQuestionNum, correctCount: self.correctCount, workbook: self.workbook)
    }
    
    func quitSolving() {
        stopTimer()
        
        status = .back
    }
}

// MARK: タイマー処理
extension QuestionViewModel {
    
    func updateTimer(timer: Timer) {
        if status != .solve { return }
        
        totalTime += timer.timeInterval
        
        // TODO: モードによって変える
        if remainingTime <= 0 {
//            endSolving()
            remainingTime = 0
            return
        }
        
        remainingTime -= timer.timeInterval
        
        updateProgressBarColor()
        
    }
    
    func stopTimer() {
        guard let _ = timer else { return }
        
        timer.invalidate()
    }

}
