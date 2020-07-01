//
//  QuestionViewModel.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/06/30.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

class QuestionViewModel: ObservableObject {
    
    private var questions: Array<Question> = [
        Question(questionText: "QuestionText1", answer: "Answer", choices: ["Answer", "B", "C", "D"]),
        Question(questionText: "QuestionText2", answer: "Answer", choices: ["Answer", "C", "C", "D"]),
        Question(questionText: "QuestionText3", answer: "Answer", choices: ["Answer", "D", "C", "D"]),
    ]
    
    var maxQuestionNum: Int = 3
    
    @Published var nowQuestionNum: Int = 0
    
    @Published var nowQuestion: Question!
    
    func sendUserChoice(choice: String) {
        goToNextQuestion()
    }
    
    // 次の問題があればnowQuestionNumをインクリメント、なければリザルト画面へ遷移
    func goToNextQuestion() {
        if nowQuestionNum < maxQuestionNum - 1 {
            nowQuestionNum += 1
            nowQuestion = questions[nowQuestionNum]
        } else {
            // TODO: リザルト画面へ遷移
            // タイマーを止める必要があ
        }
    }
    
    init() {
        nowQuestion = questions[nowQuestionNum]
    }

}
