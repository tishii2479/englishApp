//
//  Category.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/15.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var title: String = ""
    @objc dynamic var detail: String = ""
    @objc dynamic var totalQuestionNum: Int = 0
    @objc dynamic var correctQuestionNum: Int = 0
    
    init(title: String, detail: String, totalQuestionNum: Int, correctQuestionNum: Int) {
        self.title = title
        self.detail = detail
        self.totalQuestionNum = totalQuestionNum
        self.correctQuestionNum = correctQuestionNum
    }
    
    required init() {}
    
    func incrementCorrectCount() {
        do {
            let realm = try Realm()
            
            try realm.write { self.correctQuestionNum += 1 }
        } catch {
            print("failed to increment correct count at category")
        }
    }
    
}
