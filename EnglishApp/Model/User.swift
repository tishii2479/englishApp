//
//  User.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/05.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import Foundation
import RealmSwift

class User: ObservableObject {
 
    @Published var todayCorrectCount: Int = 0
    
    @Published var todayMissCount: Int = 0
    
    @Published var totalCorrectCount: Int = 0

    @Published var totalMissCount: Int = 0
    
    @Published var completedWorkbookCount: Int = 0
    
    @Published var onedayQuota: Int = 50
    
    var timePerQuestion: Int = 20
    
    var maxQuestionNum: Int = 10
    
    var showCorrectness: Bool = true
    
    static let shared = User()
    
    func correctRatioFormatter(correct: Int, miss: Int) -> String {
        if totalCorrectCount + totalMissCount > 0 {
            return String(format: "%.1f", Double(totalCorrectCount * 100) / Double(totalCorrectCount + totalMissCount))
        } else {
            return "0.0"
        }
    }
    
    func incrementCorrectCount() {
        totalCorrectCount += 1
        todayCorrectCount += 1
        
        UserDefaults.standard.set(totalCorrectCount, forKey: "totalCorrectCount")
        UserDefaults.standard.set(todayCorrectCount, forKey: "todayCorrectCount")
    }
    
    func incrementMissCount() {
        totalMissCount += 1
        todayMissCount += 1
        
        UserDefaults.standard.set(totalMissCount, forKey: "totalMissCount")
        UserDefaults.standard.set(todayMissCount, forKey: "todayMissCount")
    }
    
    func incrementClearCount() {
        completedWorkbookCount += 1
        
        UserDefaults.standard.set(completedWorkbookCount, forKey: "completedWorkbookCount")
    }

    func setUserSetting(key: String, value: Int) {
        UserDefaults.standard.set(value, forKey: key)
        
        switch key {
        case "timePerQuestion":
            timePerQuestion = value
        case "maxQuestionNum":
            maxQuestionNum = value
        case "oneDayQuota":
            onedayQuota = value
        default:
            print("error: switch key is invalid: \(key)")
        }
    }
    
}
