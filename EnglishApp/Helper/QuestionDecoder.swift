//
//  QuestionDecoder.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/05.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import Foundation
import RealmSwift

class QuestionDecoder {
    
    static func convertCsvFileToRealmObject(fileName: String) {
        
        var questionArr = [Question]()
        
        guard let dataArr: Array<String> = CSVDecoder.convertCSVFileToStringArray(fileName: fileName) else { return }
        
        for data in dataArr {
            let arr = data.components(separatedBy: ",")
            
            // 要素数のチェック
            if arr.count != 9 { return }
            guard let correct = Int(arr[7]) else { return }
            guard let miss = Int(arr[8]) else { return }
            
            let question = Question(bookId: arr[0], questionText: arr[1], answer: arr[2], choice1: arr[3], choice2: arr[4], choice3: arr[5], choice4: arr[6], correctCount: correct, missCount: miss)
            
            questionArr.append(question)
        }
        
        do {
            let realm = try Realm()
            
            try realm.write({
                realm.deleteAll()
            })
            
            try questionArr.forEach { question in
                
                try realm.write({
                    realm.add(question)
                })
            }
        } catch {
            print("realm not working")
        }
        
    }
    
}
