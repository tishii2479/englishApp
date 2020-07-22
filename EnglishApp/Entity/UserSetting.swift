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
        
        checkNewVersionUpdate()
        checkFirstActivationOfToday()
    }
    
    static func checkNewVersionUpdate() {
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String

        setUpCategories()
        setUpWorkbooks()
        
        // 初回起動
        if UserDefaults.standard.string(forKey: "appVersion") == nil {
            print("first activate")
            resetQuestions()
            UserDefaults.standard.set(version, forKey: "appVersion")
        }
        // 新しいバージョンがある時
        else if version != UserDefaults.standard.string(forKey: "appVersion") {
            print("new version")
            loadDataWithVersion(version: version)
            
            UserDefaults.standard.set(version, forKey: "appVersion")
        }
        // 通常起動
        else {
            print("normal activate")
        }
        
        setUpUserInformation()
    }

    static func checkFirstActivationOfToday() {
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
    static func setUpUserInformation() {
        let userDefaults = UserDefaults.standard
        
        User.shared.onedayQuota                 = userDefaults.integer(forKey: "oneDayQuota")
        User.shared.maxQuestionNum              = userDefaults.integer(forKey: "maxQuestionNum")
        User.shared.timePerQuestion             = userDefaults.integer(forKey: "timePerQuestion")
        User.shared.todayCorrectCount           = userDefaults.integer(forKey: "todayCorrectCount")
        User.shared.todayMissCount              = userDefaults.integer(forKey: "todayMissCount")
        User.shared.totalCorrectCount           = userDefaults.integer(forKey: "totalMissCount")
        User.shared.totalMissCount              = userDefaults.integer(forKey: "totalMissCount")
        User.shared.completedWorkbookCount      = userDefaults.integer(forKey: "completedWorkbookCount")
    }
    
    static func resetUserInformation() {
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
    
    static func resetRealm() {
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        let realm = try! Realm(configuration: config)
        
        try! realm.write { realm.deleteAll() }
    }
    
    static func setUpCategories() {
        CSVDecoder.convertWorkbookFile(fileName: "workbook")
        
        guard let categories: Results<Category> = RealmDecoder.fetchAllDatas(filter: nil) else { fatalError("failed to conver category") }
        
        workbookCategories = Array(categories)
    }
    
    static func setUpWorkbooks() {
        CSVDecoder.convertCategoryFile(fileName: "category")
        
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
    
    static func resetQuestions() {
        for arr in workbookArray.values {
            for w in arr {
                CSVDecoder.convertQuestionFile(fileName: w.bookId)
            }
        }
    }
    
    static func deleteUserData() {
        resetUserInformation()
        
        guard let workbookArray: Results<Workbook> = RealmDecoder.fetchAllDatas(filter: nil) else {
            fatalError("workbookのdataに問題があります")
        }
        do {
            let realm = try Realm()
            
            for w in workbookArray {
                try realm.write {
                    w.correctCount = 0
                    w.missCount = 0
                    w.isCleared = false
                }
            }
        } catch {
            print("failed to delete data")
        }
        
        resetQuestions()
    }
    
    static func loadDataWithVersion(version: String) {
        
    }
}
