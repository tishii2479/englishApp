//
//  CSVDecoder.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/04.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import Foundation

class CSVDecoder {
    
    static func convertCSVFileToStringArray(fileName: String) -> Array<String>? {
        var csvLines = [String]()
        
        guard let path = Bundle.main.path(forResource: fileName, ofType: "csv") else {
            print("error: csv file not found")
            return nil
        }
        
        do {
            let csvString = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            csvLines = csvString.components(separatedBy: .newlines)
            csvLines.removeLast()   // 最後の改行を削除
        } catch let error as NSError {
            print("error: data not found, message: \(error)")
            return nil
        }
        
        return csvLines
    }
    
    static func convertQuestionFile(fileName: String) {
        
        var questionArr = [Question]()
        
        guard let dataArr: Array<String> = CSVDecoder.convertCSVFileToStringArray(fileName: fileName) else { return }
        
        for data in dataArr {
            let arr = data.components(separatedBy: ",")
        
            // FIXME: 改行が空の要素として見つかるため、抜き出す
            if arr.count == 1 { continue }
            
            // 要素数のチェック
            guard arr.count == 5  else { fatalError("failed to convert question") }
            
            var choices = [String]()
            for i in 0 ..< 4 {
                choices.append(arr[i + 1].replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "\\", with: ""))
            }
            choices = choices.shuffled()
            
            let text = arr[0].replacingOccurrences(of: "_", with: ",").replacingOccurrences(of: "*", with: " _______ ").replacingOccurrences(of: "\\", with: "")
            
            let question = Question(bookId: fileName, questionText: text, answer: arr[1], choice1: choices[0], choice2: choices[1], choice3: choices[2], choice4: choices[3], correctCount: 0, missCount: 0, isSaved: false)
            
            questionArr.append(question)
        }
        
        RealmDecoder.addDataToRealm(datas: questionArr)
    }
    
    static func convertWorkbookFile(fileName: String) {
        var workbookArr = [Workbook]()
        
        guard let dataArr: Array<String> = CSVDecoder.convertCSVFileToStringArray(fileName: fileName) else {
            return
        }
        
        for data in dataArr {
            let arr = data.components(separatedBy: ",")
            
            // 要素数のチェック
            guard arr.count == 7,
                let difficulty = Int(arr[3]),
                let questionNumber = Int(arr[4]),
                let price = Int(arr[5]) else { fatalError("failed to convert workbook") }
            
            let isPurchased = price == 0
            
            let workbook = Workbook(bookId: arr[0], title: arr[1], detail: arr[2], difficulty: difficulty, questionNumber: questionNumber, price: price, correctCount: 0, missCount: 0, isPurchased: isPurchased, category: arr[6])
            
            workbookArr.append(workbook)
        }
        
        RealmDecoder.addDataToRealm(datas: workbookArr)
    }
    
    static func convertCategoryFile(fileName: String) {
        var categoryArr = [Category]()
        
        guard let dataArr: Array<String> = CSVDecoder.convertCSVFileToStringArray(fileName: fileName) else {
            return
        }
        
        for data in dataArr {
            let arr = data.components(separatedBy: ",")
            
            guard arr.count == 1 else { fatalError("failed to convert category") }
            
            let category = Category(title: arr[0])
            
            categoryArr.append(category)
        }
        
        RealmDecoder.addDataToRealm(datas: categoryArr)
    }
    
}