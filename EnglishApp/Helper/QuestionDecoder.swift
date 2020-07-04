//
//  QuestionDecoder.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/04.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import Foundation

class QuestionDecoder {
    
    func fetchQuestionFromWorkbookId(workbookId: String) -> Array<Question>? {
        return
            [
            Question(questionText: "QuestionText1", answer: "Answer", choices: ["Answer", "B", "C", "D"]),
            Question(questionText: "QuestionText2", answer: "Answer", choices: ["Answer", "C", "C", "D"]),
            Question(questionText: "QuestionText3", answer: "Answer", choices: ["Answer", "D", "C", "D"]),
            Question(questionText: "QuestionText1", answer: "Answer", choices: ["Answer", "B", "C", "D"]),
            Question(questionText: "QuestionText2", answer: "Answer", choices: ["Answer", "C", "C", "D"]),
            Question(questionText: "QuestionText3", answer: "Answer", choices: ["Answer", "D", "C", "D"]),
        ]
    }
    
}
