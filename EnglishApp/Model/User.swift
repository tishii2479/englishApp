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
    
    func correctRatioFormatter(correct: Int, miss: Int) -> String {
        if totalCorrectCount + totalMissCount > 0 {
            return String(format: "%.1f", Double(totalCorrectCount * 100) / Double(totalCorrectCount + totalMissCount))
        } else {
            return "0.0"
        }
    }
}
