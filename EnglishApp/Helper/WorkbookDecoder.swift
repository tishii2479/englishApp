//
//  WorkbookDecoder.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/04.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import Foundation

class WorkbookDecoder {
    
    static func fetchAllWorkbook() -> [Workbook]? {
        var workbookArr = [Workbook]()
        
        guard let dataArr: Array<String> = CSVDecoder.convertCSVFileToStringArray(resourceName: "workbook") else {
            return nil
        }
        
        for i in 1 ..< dataArr.count {
            let arr = dataArr[i].components(separatedBy: ",")
            
            // 要素数のチェック
            if arr.count != 9 { return nil }
            guard let difficulty = Int(arr[3]) else { return nil }
            guard let questionNumber = Int(arr[4]) else { return nil }
            guard let price = Int(arr[5]) else { return nil }
            guard let correct = Int(arr[6]) else { return nil }
            guard let miss = Int(arr[7]) else { return nil }
            guard let _isPurchased = Int(arr[8]) else { return nil }
            let isPurchased = _isPurchased == 1
            
            workbookArr.append(Workbook(bookId: arr[0], title: arr[1], detail: arr[2], difficulty: difficulty, questionNumber: questionNumber, price: price, correctCount: correct, missCount: miss, isPurchased: isPurchased))
        }
        
        return workbookArr
    }
    
}
