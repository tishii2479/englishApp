//
//  FirebaseManager.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/08/18.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftUI
import FirebaseStorage
import FirebaseFirestore

class FirebaseManager {
    
    static func authenticate(email: String, errorMessage: inout String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: email)
        
        if result == false {
            errorMessage = "入力が メールアドレスの形式でありません。"
            return true
        }
        
        // Success
        UserDefaults.standard.set(email, forKey: "email")
        User.shared.email = email
        
        setUserPurchaseData()
        
        User.shared.showLogin = false
        return false
    }
    
    static func setUserPurchaseData() {
        
        let email = User.shared.email
        let db = Firestore.firestore()
        
        guard let purchasedWorkbook = Workbook.getPurchasedWorkbook() else {
            fatalError("workbook unexist")
        }
        
        db.collection("users").document(email).setData([
            "coin" : User.shared.coin,
            "purchasedWorkbook" : purchasedWorkbook,
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    static func getUserPurchaseData() -> String {
        
        let email = User.shared.email
        
        let db = Firestore.firestore()
        
        var errorMessage: String = ""
        
        db.collection("users").document(email).getDocument { (document, error) in
            if let document = document, document.exists {
                guard let data = document.data() else {
                    print("failed to get purchase data")
                    errorMessage = "エラー: 40001"
                    return
                }
                guard let coin = data["coin"],
                    let _purchasedWorkbookArray = data["purchasedWorkbook"] else {
                        print("purchase data is invalid")
                        errorMessage = "エラー: 40002"
                        return
                }
                
                User.shared.coin = Int(String(describing: coin))!
                UserDefaults.standard.set(User.shared.coin, forKey: "coin")
                
                let purchasedWorkbookArray = _purchasedWorkbookArray as! [String]
                
                for w in purchasedWorkbookArray {
                    guard let workbook: Workbook = RealmDecoder.fetchAllDatas(filter: "bookId == '\(w)'")?[0] else {
                        errorMessage = "エラー: 40003"
                        return
                    }
                    
                    do {
                        let realm = try Realm()
                        
                        try realm.write {
                            workbook.isPurchased = true
                        }
                    } catch {
                        print("realm did not work")
                    }
                }
                
            } else {
                print("Document does not exist")
                errorMessage = "エラー: 40004"
            }
        }
        
        return errorMessage
    }
    
}
