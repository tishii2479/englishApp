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
    
    static var workbookArray: Dictionary<String, Array<Workbook>>!
    
    static var workbookCategories: Array<Category>!
    
    static func setUp() {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    
        checkFirstActivationOfToday()

        // Comment out these to test memory
//        resetUserInformation()
        setUpRealm()

        setUpUserInformation()
        setUpCategories()
        setUpWorkbooks()
    }

    private static func checkFirstActivationOfToday() {
        let todayDate: String = Date.getTodayDate()
        let userDefaults = UserDefaults.standard
        
        if todayDate != userDefaults.string(forKey: "recentActivation") {
            print("first activation of today")
            
            // 今日最初の起動
            userDefaults.set(todayDate, forKey: "recentActivation")
            userDefaults.set(0, forKey: "todayCorrectCount")
            userDefaults.set(0, forKey: "todayMissCount")
        }
    }
    
    // TODO: 設定項目の更新処理を追加する必要がある
    // 特にtodayCorrect/MissCountの更新
    private static func setUpUserInformation() {
        let userDefaults = UserDefaults.standard
        
        User.shared.onedayQuota             = userDefaults.integer(forKey: "oneDayQuota")
        User.shared.maxQuestionNum              = userDefaults.integer(forKey: "maxQuestionNum")
        User.shared.timePerQuestion             = userDefaults.integer(forKey: "timePerQuestion")
        User.shared.todayCorrectCount           = userDefaults.integer(forKey: "todayCorrectCount")
        User.shared.todayMissCount              = userDefaults.integer(forKey: "todayMissCount")
        User.shared.totalCorrectCount           = userDefaults.integer(forKey: "totalMissCount")
        User.shared.totalMissCount              = userDefaults.integer(forKey: "totalMissCount")
        User.shared.completedWorkbookCount      = userDefaults.integer(forKey: "completedWorkbookCount")
    }
    
    private static func resetUserInformation() {
        let userDefaults = UserDefaults.standard
        userDefaults.removeAll()
        
        userDefaults.set(50,    forKey: "oneDayQuota")
        userDefaults.set(10,    forKey: "maxQuestionNum")
        userDefaults.set(20,    forKey: "timePerQuestion")
        userDefaults.set(0,     forKey: "todayCorrectCount")
        userDefaults.set(0,     forKey: "todayMissCount")
        userDefaults.set(0,     forKey: "totalCorrectCount")
        userDefaults.set(0,     forKey: "totalMissCount")
        userDefaults.set(0,     forKey: "completedWorkbookCount")
    }
    
    private static func setUpRealm() {
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        let realm = try! Realm(configuration: config)
        
        try! realm.write { realm.deleteAll() }
        
        CSVDecoder.convertWorkbookFile(fileName: "workbook")
        CSVDecoder.convertCategoryFile(fileName: "category")
        CSVDecoder.convertQuestionFile(fileName: "20200001")
        CSVDecoder.convertQuestionFile(fileName: "20200102")
    }
    
    private static func setUpCategories() {
        guard let categories: Results<Category> = RealmDecoder.fetchAllDatas(filter: nil) else { fatalError("failed to conver category") }
        
        workbookCategories = Array(categories)
    }
    
    private static func setUpWorkbooks() {
        
        guard let _workbookArray: Results<Workbook> = RealmDecoder.fetchAllDatas(filter: nil) else {
            fatalError("workbookのdataに問題があります")
        }
        
        var dic: Dictionary<String, Array<Workbook>> = [:]
        
        for category in workbookCategories {
            dic.updateValue([], forKey: category.title)
        }

        for workbook in _workbookArray {
            var isFirstWorkbookOfCategory = true
            
            for category in workbookCategories {
                if workbook.category == category.title {
                    dic[category.title]?.append(workbook)
                    isFirstWorkbookOfCategory = false
                }
            }
            
            if isFirstWorkbookOfCategory {
                fatalError("category name is invalid")
            }
        }
        
        workbookArray = dic
    }
    
}
