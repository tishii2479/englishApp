//
//  Question.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/06/30.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import Foundation

class Question {
    
    var questionText: String = ""
     
    var answer: String = ""
    
    var choices: Array<String> = []
    
    init(questionText: String, answer: String, choices: Array<String>) {
        self.questionText = questionText
        self.answer = answer
        self.choices = choices
    }
    
}
