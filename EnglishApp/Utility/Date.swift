//
//  Date.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/05.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import Foundation

extension Date {
    
    // 今日の日付を yyyy/MM/dd 形式で返す
    static func getTodayDate() -> String {
        let f = DateFormatter()
        f.dateStyle = .medium
        f.timeStyle = .none
        f.locale = Locale(identifier: "ja_JP")
        
        return f.string(from: Date())
    }
    
}
