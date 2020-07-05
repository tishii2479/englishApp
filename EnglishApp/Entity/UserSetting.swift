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
    
    static var onedayQuota: Int = 50
    
    static var workbookArray: Results<Workbook>!

    static var user: User!
    
    static func setUp() {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    
        user = User()
        
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
        
        timePerQuestion             = userDefaults.integer(forKey: "timePerQuestion")
        maxQuestionNum              = userDefaults.integer(forKey: "maxQuestionNum")
        timePerQuestion             = userDefaults.integer(forKey: "timePerQuestion")
        user.todayCorrectCount      = userDefaults.integer(forKey: "todayCorrectCount")
        user.todayMissCount         = userDefaults.integer(forKey: "todayMissCount")
        user.totalCorrectCount      = userDefaults.integer(forKey: "totalMissCount")
        user.totalMissCount         = userDefaults.integer(forKey: "totalMissCount")
        user.completedWorkbookCount = userDefaults.integer(forKey: "completedWorkbookCount")
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
        
        WorkbookDecoder.convertCsvFileToRealmObject(fileName: "workbook")
        QuestionDecoder.convertCsvFileToRealmObject(fileName: "20200704")
    }
    
}
