//
//  UserSetting.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/04.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import Foundation
import RealmSwift

class UserSetting {
    
    static var timePerQuestion: Int = 20
    
    static var maxQuestionNum: Int = 10
    
    static var workbookArray: Results<Workbook>!
    
    static func setUp() {
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
//        QuestionDecoder.convertCsvFileToRealmObject(fileName: "20200704")
//        WorkbookDecoder.convertCsvFileToRealmObject(fileName: "workbook")
        
        guard let _workbookArray: Results<Workbook> = RealmDecoder.fetchAllDatas() else {
            fatalError("workbookのdataに問題があります")
        }
        
        workbookArray = _workbookArray
    }
    
}
