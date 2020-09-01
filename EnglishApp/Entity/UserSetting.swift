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
        
        checkActivationStatus()
    }

    // 初回起動
    // 行われるべき処理
    // 1. データを全て読み込む、問題を含む
    // 2. 問題集データを読み込む
    // 3. 問題をrealmにセットする
    // 4. UserDefaultsの初期化
    // 5. バージョンの設定
    static func firstActivation(version: String) {
        print("first activate")

        ScreenSwitcher.shared.isLoading = true
        UserDefaultsHelper.resetUserInformation()
        
        RealmDecoder.deleteAllDataOf(data: Workbook())
        RealmDecoder.deleteAllDataOf(data: Category())

        let workbookArr = CSVDecoder.convertWorkbookFile(fileName: "workbook")
        RealmDecoder.addDataToRealm(datas: workbookArr)
        let categoryArr = CSVDecoder.convertCategoryFile(fileName: "category")
        RealmDecoder.addDataToRealm(datas: categoryArr)

        setUpWorkbooks()
        
        DispatchQueue.global(qos: .userInitiated).async {
            resetQuestionData()
            
            DispatchQueue.main.async {
                ScreenSwitcher.shared.isLoading = false
                ScreenSwitcher.shared.loadingText = ""
            }
        }
                
        UserDefaults.standard.set(version, forKey: "appVersion")
    }

    // 新しいバージョンがある時
    // 行われるべき処理
    // 1. 新しいバージョンに適したデータを読み込む、問題を含む（loadDataWithVersion)
    // 2. 問題集データの配列に入れる
    // 3. バージョンの設定
    // バージョンに変更があった場合、初回起動時に呼び出される
    // バージョン変更があった時には、その時バージョンのworkbookとcategoryファイルを読み込む
    static func loadDataWithNewVersion(version: String) {
        print("new version")
        
        let newCategoryArr = CSVDecoder.convertCategoryFile(fileName: "category")
        let newWorkbookArr = CSVDecoder.convertWorkbookFile(fileName: "workbook")
        RealmDecoder.deleteAllDataOf(data: Category())
        RealmDecoder.addDataToRealm(datas: newCategoryArr)
        
        guard let oldWorkbookArr: Results<Workbook> = RealmDecoder.fetchAllDatas(filter: nil) else { fatalError("no old workbook") }
        
        for newWorkbook in newWorkbookArr {
            var isNewBook = true
            for oldWorkbook in oldWorkbookArr {
                if newWorkbook.bookId == oldWorkbook.bookId {
                    isNewBook = false
                    break
                }
            }
            if isNewBook {
                print("new book: \(newWorkbook.bookId)")
                
                // もし前回途中でロードを中断していたら、その分を削除
                if let existingData: Results<Workbook> = RealmDecoder.fetchAllDatas(filter: "bookId == '\(newWorkbook.bookId)'") {
                    RealmDecoder.deleteData(data: existingData)
                }
                
                let newQuestions = CSVDecoder.convertQuestionFile(fileName: newWorkbook.bookId)
                RealmDecoder.addDataToRealm(datas: newQuestions)
                RealmDecoder.addDataToRealm(datas: [newWorkbook])
            }
        }
        
        setUpWorkbooks()
        UserDefaults.standard.set(version, forKey: "appVersion")
    }
    
    static func normalActivation() {
        print("normal activate")
        setUpWorkbooks()
    }
    
    static func activateWithReload() {
        print("activate with reload")
        setUpWorkbooks()
        reloadData()
        
        UserDefaults.standard.set(false, forKey: "needReload")
    }
    
    static func userInformationSetUp() {
        let todayDate: String = Date.getTodayDate()
        let userDefaults = UserDefaults.standard
        
        // 今日最初の起動かどうか
        if todayDate != userDefaults.string(forKey: "recentActivation") {
            print("first activation of today")
            userDefaults.set(todayDate, forKey: "recentActivation")
            userDefaults.set(0, forKey: "todayCorrectCount")
            userDefaults.set(0, forKey: "todayMissCount")
        }
        
        UserDefaultsHelper.setUpUserInformation()
    }
    
    static func checkActivationStatus() {
        
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        let userDefaults = UserDefaults.standard
        
        
        if UserDefaults.standard.string(forKey: "email") != "" &&
            UserDefaults.standard.string(forKey: "email") != nil
            {
            userDefaults.set(true, forKey: "userStarted")
        }
 
        if UserDefaults.standard.bool(forKey: "userStarted") == false {
            ScreenSwitcher.shared.showLogin = true
        }
        
        if UserDefaults.standard.string(forKey: "appVersion") == nil {
            // 初回起動
            firstActivation(version: version)
        }
        else if version != userDefaults.string(forKey: "appVersion") {
            // バージョンアップがある場合
            loadDataWithNewVersion(version: version)
        }
        else if userDefaults.bool(forKey: "needReload") {
            // リロードが必要な場合
            activateWithReload()
        }
        else {
            // 通常起動
            normalActivation()
        }
        
        userInformationSetUp()
        
        print(User.shared.email)
    }
    
    // 問題集を配列に読み込む時に使う
    // 毎回起動時に呼ばれる
    static func setUpWorkbooks() {
        guard let categories: Results<Category> = RealmDecoder.fetchAllDatas(filter: nil) else { fatalError("failed to conver category") }
        
        workbookCategories = Array(categories)
        
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
                print(categories)
                print(workbook.category)
                fatalError("category name is invalid")
            }
        }
        
        workbookArray = dic
    }
    
    // 問題データを初期化するときに使う
    // 学習データを消去するときのみに呼び出す
    // それ以外の時に呼び出すとデータが消えてしまう
    static func resetQuestionData() {
        let start = Date()
        
        RealmDecoder.deleteAllDataOf(data: Question())
        
        guard let workbooks: Results<Workbook> = RealmDecoder.fetchAllDatas(filter: nil) else {
            fatalError("workbook not fetched")
        }
    
        let max: Int = workbooks.count
        var now: Int = 0
        
        for w in workbooks {
            print(w.bookId)
            now += 1
            DispatchQueue.main.async {
                ScreenSwitcher.shared.loadingText = "問題集をロード中...  \(now)/\(max)"
            }
            let questionArr = CSVDecoder.convertQuestionFile(fileName: w.bookId)
            RealmDecoder.addDataToRealm(datas: questionArr)
        }
    
        let elapsed = Date().timeIntervalSince(start)
        print("elapsed: \(elapsed)")
    }
    
    // ユーザーの学習データを削除する時にのみ使用する
    static func deleteUserData() {
        UserDefaultsHelper.resetUserInformation()
        
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
        
        resetQuestionData()
        
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        
        UserDefaults.standard.set(version, forKey: "appVersion")
        
        print("deleted data")
    }
    
    // 正解数、不正解数をリロード
    static func reloadData() {
        
        // Questionが古い
        guard let questionArr: Results<Question> = RealmDecoder.fetchAllDatas(filter: nil),
            let workbookArr: Results<Workbook> = RealmDecoder.fetchAllDatas(filter: nil) else {
                print("failed to reloadData")
                return
        }
        
        var correctCount: Int = 0
        var missCount: Int = 0
        var completedWorkbookCount: Int = 0
        
        for q in questionArr {
            correctCount += q.correctCount
            missCount += q.missCount
        }
        
        for w in workbookArr {
            if w.isCleared {
                completedWorkbookCount += 1
            }
        }
        
        UserDefaults.standard.set(correctCount, forKey: "totalCorrectCount")
        UserDefaults.standard.set(missCount, forKey: "totalMissCount")
        UserDefaults.standard.set(completedWorkbookCount, forKey: "completedWorkbookCount")
        
        User.shared.totalCorrectCount = correctCount
        User.shared.totalMissCount = missCount
        User.shared.completedWorkbookCount = completedWorkbookCount
        
        print(correctCount, missCount, completedWorkbookCount)
    }
}
