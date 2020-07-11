//
//  WorkbookDecoder.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/04.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import Foundation
import RealmSwift

class WorkbookDecoder {
    
    // 要らなくなるかも
    static func convertCsvFileToRealmObject(fileName: String) {
        var workbookArr = [Workbook]()
        
        guard let dataArr: Array<String> = CSVDecoder.convertCSVFileToStringArray(fileName: fileName) else {
            return
        }
        
        for data in dataArr {
            let arr = data.components(separatedBy: ",")
            
            // 要素数のチェック
            if arr.count != 9 { return }
            guard let difficulty = Int(arr[3]) else { return }
            guard let questionNumber = Int(arr[4]) else { return }
            guard let price = Int(arr[5]) else { return }
            guard let correct = Int(arr[6]) else { return }
            guard let miss = Int(arr[7]) else { return }
            guard let _isPurchased = Int(arr[8]) else { return }
            let isPurchased = _isPurchased == 1
            
            let workbook = Workbook(bookId: arr[0], title: arr[1], detail: arr[2], difficulty: difficulty, questionNumber: questionNumber, price: price, correctCount: correct, missCount: miss, isPurchased: isPurchased)
            
            workbookArr.append(workbook)
        }
        
        RealmDecoder.addDataToRealm(datas: workbookArr)
        
    }
    
}
