//
//  Question.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/06/30.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import Foundation

struct Question {
    
    var questionText: String
     
    var answer: String
    
    var choices: Array<String>
    
    var correctCount: Int
    
    var missCount: Int
    
}
