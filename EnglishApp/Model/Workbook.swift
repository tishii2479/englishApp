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
    
    @objc dynamic var bookId: String = "20200001"
    
    @objc dynamic var title: String = "title"

    @objc dynamic var detail: String = "detail"
    
    @objc dynamic var category: String = ""

    @objc dynamic var difficulty: Int = 1

    @objc dynamic var questionNumber: Int = 0

    @objc dynamic var price: Int = 0

    @objc dynamic var correctCount: Int = 0

    @objc dynamic var missCount: Int = 0
    
    @objc dynamic var likeCount: Int = 0

    @objc dynamic var isPurchased: Bool = false
    
    @objc dynamic var isCleared: Bool = false
    
    @objc dynamic var isPlayable: Bool = false
    
    var questions: Results<Question>?
    
    var solveMode: SolveMode = .all
    
    required init() {}
    
    init(bookId: String, title: String, detail: String, category: String, difficulty: Int, questionNumber: Int, price: Int, correctCount: Int, missCount: Int, isPurchased: Bool, isCleared: Bool, isPlayable: Bool) {
        self.bookId = bookId
        self.title = title
        self.detail = detail
        self.difficulty = difficulty
        self.questionNumber = questionNumber
        self.price = price
        self.correctCount = correctCount
        self.missCount = missCount
        self.isPurchased = isPurchased
        self.category = category
        self.isCleared = isCleared
        self.isPlayable = isPlayable
    }

    func fetchQuestions(questionNum: Int, solveMode: SolveMode) -> Array<Question>? {
        var filter: String?
        
        switch solveMode {
        case .onlyNew:
            filter = "missCount == 0 AND correctCount == 0 AND bookId == '\(self.bookId)'"
        case .onlyMissed:
            filter = "missCount > 0 AND correctCount == 0 AND bookId == '\(self.bookId)'"
        case .all:
            filter = "bookId == '\(self.bookId)'"
        case .test:
            filter = "bookId == '\(self.bookId)'"
        case .liked:
            filter = "isLiked == true AND bookId == '\(self.bookId)'"
        case .random:
            filter = nil
        }
        
        questions = RealmDecoder.fetchAllDatas(filter: filter)
        
        if questions == nil { fatalError("questions could not be fetched") }
        
        var temp = Array(questions!)
        
        var questionArr = Array<Question>()
        
        let n = solveMode == .test ? 10 : questionNum
        
        for _ in 0 ..< n {
            if temp.count < 1 { return questionArr }
            let index = Int.random(in: 0 ..< temp.count)
            
            questionArr.append(temp[index])
            temp.remove(at: index)
        }
        
        return questionArr
    }
    
    static func getPurchasedWorkbook() -> Array<String>? {
        var purchasedIdArr = Array<String>()
        
        guard let workbookArr: Results<Workbook> = RealmDecoder.fetchAllDatas(filter: nil) else { return nil }
        
        for workbook in workbookArr {
            if workbook.isPurchased {
                purchasedIdArr.append(workbook.bookId)
            }
        }
        
        return purchasedIdArr
    }
    
    func setNextWorkbookPlayable() {
        guard   let workbookArr = UserSetting.workbookArray[category],
                let workbookId: Int = Int(bookId.components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined())
        else { fatalError() }
        
        for workbook in workbookArr {
            let id: Int = Int(workbook.bookId.components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined()) ?? 0
            
            if workbookId + 1 == id {
                workbook.setPlayable(isPlayable: true)
                print("next book found: \(workbook.title)")
                return
            }
        }
        
        print("next book not found")
    }
    
    func updateCount(type: CountType, amount: Int) {
        
        do {
            let realm = try Realm()
            
            switch type {
            case .correct:
                try realm.write { self.correctCount += amount }
            case .miss:
                try realm.write { self.missCount += amount }
            case .like:
                try realm.write { self.likeCount += amount }
            }
        } catch {
            print("failed to update count")
        }
    }
    
    func setCleared(isCleared: Bool) {
        do {
            let realm = try Realm()
            
            try realm.write { self.isCleared = isCleared }
        } catch {
            print("failed to update iscleared")
        }
    }
    
    func setPlayable(isPlayable: Bool) {
        do {
            let realm = try Realm()
            
            try realm.write { self.isPlayable = isPlayable }
        } catch {
            print("failed to update isplayable")
        }
    }
    
    func purchase() {
        print("purchase")
        
        do {
            let realm = try Realm()
            
            try realm.write { self.isPurchased = true }

            User.shared.updateUserCoins(difference: -1 * self.price)
        } catch {
            print("failed to purcahse")
        }
    }
    
}
