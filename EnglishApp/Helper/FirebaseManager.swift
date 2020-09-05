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
    
    static func setUserPurchaseData() {
        
        let email = User.shared.email
        
        let db = Firestore.firestore()
        
        if email == "" { return }
        
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
        
        if email == "" { return "" }
        
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
