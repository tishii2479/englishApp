//
//  UserDefaultHelper.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/22.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import Foundation

class UserDefaultsHelper {
    
    static func setUpUserInformation() {
        let userDefaults = UserDefaults.standard
        
        User.shared.onedayQuota                 = userDefaults.integer(forKey: "oneDayQuota")
        User.shared.maxQuestionNum              = userDefaults.integer(forKey: "maxQuestionNum")
        User.shared.timePerQuestion             = userDefaults.integer(forKey: "timePerQuestion")
        User.shared.todayCorrectCount           = userDefaults.integer(forKey: "todayCorrectCount")
        User.shared.todayMissCount              = userDefaults.integer(forKey: "todayMissCount")
        User.shared.totalCorrectCount           = userDefaults.integer(forKey: "totalCorrectCount")
        User.shared.totalMissCount              = userDefaults.integer(forKey: "totalMissCount")
        User.shared.completedWorkbookCount      = userDefaults.integer(forKey: "completedWorkbookCount")
        User.shared.coin                        = userDefaults.integer(forKey: "coin")
        User.shared.email                       = userDefaults.string(forKey: "email") ?? ""
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
        userDefaults.set(0,     forKey: "coin")
    }
}
