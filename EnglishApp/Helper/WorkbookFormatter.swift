//
//  WorkbookFormatter.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/04.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import Foundation

class WorkbookFormatter {
    static func formatPrice(price: Int) -> String {
        if price == 0 {
            return "無料"
        } else {
            return String(price) + "円"
        }
    }
    
    static func formatQuestionNumber(number: Int) -> String {
        return "問題数:  " + String(number) + "個"
    }
    
    static func formatDifficult(difficulty: Int) -> String {
        var result: String = "難易度:  "
        for i in 0 ..< 5 {
            if i < difficulty {
                result.append("★")
            } else {
                result.append("⭐︎")
            }
        }
        
        return result
    }
    
    static func formatStatus(isPurchased: Bool) -> String {
        if isPurchased {
            return "利用可能"
        } else {
            return "購入する"
        }
    }
}
