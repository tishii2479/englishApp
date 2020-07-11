//
//  Workbook.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/04.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI
import RealmSwift

class Workbook: Object, Identifiable {
    
    var id = UUID()
    
    @objc dynamic var bookId: String = "20200704"
    
    @objc dynamic var title: String = "title"

    @objc dynamic var detail: String = "detail"

    @objc dynamic var difficulty: Int = 1

    @objc dynamic var questionNumber: Int = 0

    @objc dynamic var price: Int = 0

    @objc dynamic var correctCount: Int = 0

    @objc dynamic var missCount: Int = 0

    @objc dynamic var isPurchased: Bool = true
    
    var questions: Results<Question>?
    
    required init() {}
    
    init(bookId: String, title: String, detail: String, difficulty: Int, questionNumber: Int, price: Int, correctCount: Int, missCount: Int, isPurchased: Bool) {
        self.bookId = bookId
        self.title = title
        self.detail = detail
        self.difficulty = difficulty
        self.questionNumber = questionNumber
        self.price = price
        self.correctCount = correctCount
        self.missCount = missCount
        self.isPurchased = isPurchased
    }

    // TODO: 問題を選ぶ際に未回答のみを選ぶ時と、間違えた問題のみを選ぶ時で分ける
    func fetchQuestions(questionNum: Int) -> Array<Question>? {
        
        // 問題がまだ見つかっていない場合にはrealmから取得
        if questions == nil {
            questions = RealmDecoder.fetchAllDatas()
        }
        
        if questions == nil { fatalError("questions could not be fetched") }
        
        // ISSUE: removeしたいからarrayにしているが、これは処理速度的によくないかもしれない
        var temp = Array(questions!)
        var questionArr = Array<Question>()
        
        for _ in 0 ..< questionNum {
            if temp.count < 1 { return questionArr }
            let index = Int.random(in: 0 ..< temp.count)
            
            questionArr.append(temp[index])
            temp.remove(at: index)
        }
        
        return questionArr
    }
    
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
