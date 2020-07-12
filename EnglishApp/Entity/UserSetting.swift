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
    
    static var workbookArray: Results<Workbook>!
    
    static func setUp() {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    
        checkFirstActivationOfToday()

        // Comment out these to test memory
//        resetUserInformation()
//        setUpRealm()

        setUpUserInformation()
        
        guard let _workbookArray: Results<Workbook> = RealmDecoder.fetchAllDatas() else {
            fatalError("workbookのdataに問題があります")
        }
        
        workbookArray = _workbookArray
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
        
        User.shared.timePerQuestion             = userDefaults.integer(forKey: "timePerQuestion")
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
        
        userDefaults.set(50,    forKey: "onedayQuota")
        userDefaults.set(10,    forKey: "maxQuestionNum")
        userDefaults.set(20,    forKey: "timePerQuestion")
        userDefaults.set(0,     forKey: "todayCorrectCount")
        userDefaults.set(0,     forKey: "todayMissCount")
        userDefaults.set(0,     forKey: "totalCorrectCount")
        userDefaults.set(0,     forKey: "totalMissCount")
        userDefaults.set(0,     forKey: "completedWorkbookCount")
    }
    
    private static func setUpRealm() {
        let realm = try! Realm()
        
        try! realm.write { realm.deleteAll() }
        
        CSVDecoder.convertWorkbookFile(fileName: "workbook")
        CSVDecoder.convertQuestionFile(fileName: "20200715")
    }
    
}
