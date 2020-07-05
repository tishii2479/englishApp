//
//  Question.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/06/30.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import Foundation
import RealmSwift

class Question: Object {
    
    @objc dynamic var bookId: String = ""
    
    @objc dynamic var questionText: String = ""
    
    @objc dynamic var answer: String = ""
    
    @objc dynamic var choice1: String = ""
    
    @objc dynamic var choice2: String = ""
    
    @objc dynamic var choice3: String = ""
    
    @objc dynamic var choice4: String = ""
     
    @objc dynamic var correctCount: Int = 0
    
    @objc dynamic var missCount: Int = 0
    
    init(bookId: String, questionText: String, answer: String, choice1: String, choice2: String, choice3: String, choice4: String, correctCount: Int, missCount: Int) {
        self.bookId = bookId
        self.questionText = questionText
        self.answer = answer
        self.choice1 = choice1
        self.choice2 = choice2
        self.choice3 = choice3
        self.choice4 = choice4
        self.correctCount = correctCount
        self.missCount = missCount
    }
    
    required init() {}
    
    func updateCount(type: CountType, amount: Int) {
        do {
            let realm = try Realm()
            
            switch type {
            case .correct:
                try realm.write { correctCount += amount }
            case .miss:
                try realm.write { missCount += amount }
            }
        } catch {
            print("failed to update count")
        }
    }
    
}
