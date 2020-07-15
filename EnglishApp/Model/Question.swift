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
    
    @objc dynamic var questionText: String = "QuestionTextQuestionTextQuestionTextQuestionTextQuestionTextQuestionTextQuestionTextQuestionTextQuestionTextQuestionText"
    
    @objc dynamic var answer: String = "choice2"
    
    @objc dynamic var choice1: String = "choice1"
    
    @objc dynamic var choice2: String = "choice2"
    
    @objc dynamic var choice3: String = "choice3"
    
    @objc dynamic var choice4: String = "choice4"
     
    @objc dynamic var correctCount: Int = 0
    
    @objc dynamic var missCount: Int = 0
    
    @objc dynamic var isSaved: Bool = false
    
    init(bookId: String, questionText: String, answer: String, choice1: String, choice2: String, choice3: String, choice4: String, correctCount: Int, missCount: Int, isSaved: Bool) {
        self.bookId = bookId
        self.questionText = questionText
        self.answer = answer
        self.choice1 = choice1
        self.choice2 = choice2
        self.choice3 = choice3
        self.choice4 = choice4
        self.correctCount = correctCount
        self.missCount = missCount
        self.isSaved = isSaved
    }
    
    required init() {}
    
    func updateCount(type: CountType, amount: Int) {
        do {
            let realm = try Realm()
            
            switch type {
            case .correct:
                try realm.write { self.correctCount += amount }
            case .miss:
                try realm.write { self.missCount += amount }
            }
        } catch {
            print("failed to update count")
        }
    }
 
    func changeIsSaved(isSaved: Bool) {
        do {
            let realm = try Realm()
            
            try realm.write { self.isSaved = isSaved }
        } catch {
            print("failed to save question")
        }
    }
}
