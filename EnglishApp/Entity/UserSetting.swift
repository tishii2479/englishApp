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
    
    // TODO: リファクタリング
    // 起動された時のステータスを確認する
    // 行われるべき順番
    // 1. データをcsvfileからrealmに移す（初回起動とバージョンアップの時のみ）
    // 2. realmから問題集のデータを配列に保持する
    // 3. その他の処理（userDefaultsの設定）
    static func checkActivationStatus() {
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        let todayDate: String = Date.getTodayDate()
        let userDefaults = UserDefaults.standard
        
        // 初回起動
        // 行われるべき処理
        // 1. データを全て読み込む、問題を含む
        // 2. 問題集データを読み込む
        // 3. 問題をrealmにセットする
        // 4. UserDefaultsの初期化
        // 5. バージョンの設定
        if UserDefaults.standard.string(forKey: "appVersion") == nil {
            print("first activate")
            UserDefaultsHelper.resetUserInformation()
            let workbookArr = CSVDecoder.convertWorkbookFile(fileName: "workbook")
            RealmDecoder.addDataToRealm(datas: workbookArr)
            let categoryArr = CSVDecoder.convertCategoryFile(fileName: "category")
            RealmDecoder.addDataToRealm(datas: categoryArr)
            
            setUpWorkbooks()
            resetQuestionData()
            userDefaults.set(version, forKey: "appVersion")
        }
        // 新しいバージョンがある時
        // 行われるべき処理
        // 1. 新しいバージョンに適したデータを読み込む、問題を含む（loadDataWithVersion)
        // 2. 問題集データの配列に入れる
        // 3. バージョンの設定
        else if version != userDefaults.string(forKey: "appVersion") {
            print("new version")
            loadDataWithNewVersion()
            setUpWorkbooks()
            userDefaults.set(version, forKey: "appVersion")
        }
        // 通常起動
        else {
            print("normal activate")
            setUpWorkbooks()
        }

        UserDefaultsHelper.setUpUserInformation()
        
        // 今日最初の起動かどうか
        if todayDate != userDefaults.string(forKey: "recentActivation") {
            print("first activation of today")
            userDefaults.set(todayDate, forKey: "recentActivation")
            userDefaults.set(0, forKey: "todayCorrectCount")
            userDefaults.set(0, forKey: "todayMissCount")
        }
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
                fatalError("category name is invalid")
            }
        }
        
        workbookArray = dic
    }
    
    // 問題データを初期化するときに使う
    // 学習データを消去するときのみに呼び出す
    // それ以外の時に呼び出すとデータが消えてしまう
    static func resetQuestionData() {
        for arr in workbookArray.values {
            for w in arr {
                let questionArr = CSVDecoder.convertQuestionFile(fileName: w.bookId)
                RealmDecoder.addDataToRealm(datas: questionArr)
            }
        }
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
    }
    
    // バージョンに変更があった場合、初回起動時に呼び出される
    // バージョン変更があった時には、その時バージョンのworkbookとcategoryファイルを読み込む
    static func loadDataWithNewVersion() {
        let newCategoryArr = CSVDecoder.convertCategoryFile(fileName: "category")
        let newWorkbookArr = CSVDecoder.convertWorkbookFile(fileName: "workbook")
        RealmDecoder.deleteAllDataOf(data: Category())
        RealmDecoder.addDataToRealm(datas: newCategoryArr)
        
        if let oldWorkbookArr: Results<Workbook> = RealmDecoder.fetchAllDatas(filter: nil) {
            
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
                    let newQuestions = CSVDecoder.convertQuestionFile(fileName: newWorkbook.bookId)
                    RealmDecoder.addDataToRealm(datas: newQuestions)
                    RealmDecoder.addDataToRealm(datas: [newWorkbook])
                }
            }
        } else {
            fatalError("no old workbook")
        }
    }
    
}
