//
//  UserSetting.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/04.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import Foundation

class UserSetting {
    
    static var timePerQuestion: Int = 20
    
    static var maxQuestionNum: Int = 10
    
    static var workbookArray = [Workbook]()
    
    static func setUp() {
        guard let _workbookArray = WorkbookDecoder.fetchAllWorkbook() else {
            print("workbookのdataに問題があります")
            return
        }
        workbookArray = _workbookArray
    }
    
}
