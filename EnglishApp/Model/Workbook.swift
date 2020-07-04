//
//  Workbook.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/04.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

class Workbook {
    
    var id: String = "20200704"
    
    var title: String = "title"
    
    var detail: String = "detail"

    var difficulty: Int = 1
    
    var questionNumber: Int = 100
    
    var price: Int = 0
    
    var correctCount: Int = 80
    
    var missCount: Int = 10

    var isPurchased: Bool = true
    
    var csvDecoder: CSVDecoder = CSVDecoder()
    
    func fetchQuestions() -> Array<Question>? {
        var questionArr = [Question]()
        
        guard let dataArr: Array<String> = csvDecoder.convertCSVFileToStringArray(resourceName: "20200704") else { return nil }
        
        for i in 1 ..< dataArr.count {
            let arr = dataArr[i].components(separatedBy: ",")
            
            print(arr)
            
            if arr.count != 8 {
                print("[debug] arr count is invalid")
                return nil
            }
            guard let correct = Int(arr[6]) else {
                print("[debug] correct is invalid")
                return nil
            }
            guard let miss = Int(arr[7]) else {
                print("[debug] miss is invalid")
                return nil
            }

            let choices: Array<String> = [arr[2], arr[3], arr[4], arr[5]]
            questionArr.append(Question(questionText: arr[0], answer: arr[1], choices: choices, correctCount: correct, missCount: miss))
        }
        
        return questionArr
    }
    
}
