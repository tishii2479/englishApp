//
//  RealmDecoder.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/05.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDecoder {

    static func fetchAllDatas<T>(filter: String?) -> Results<T>? where T: Object  {
       
        do {
            let realm = try Realm()
            
            if let _filter = filter {
                return realm.objects(T.self).filter(_filter)
            } else {
                return realm.objects(T.self)
            }
        } catch {
            print("realm did not work")
            return nil
        }

    }
    
    static func addDataToRealm<T>(datas: [T]) where T: Object {
        do {
            let realm = try Realm()
            
            try datas.forEach { data in
                try realm.write({
                    realm.add(data)
                })
            }
        } catch {
            print("realm did not work")
        }
    }
    
    static func deleteAllDataOf<T>(data: T) where T: Object {
        do {
            let realm = try Realm()
            
            let allData = realm.objects(T.self)
            
            try realm.write {
                realm.delete(allData)
            }
        } catch {
            print("realm not working")
        }
    }
    
    // データを初期化する時に使う
    static func resetRealm() {
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        let realm = try! Realm(configuration: config)
        
        try! realm.write { realm.deleteAll() }
    }
    
    
}
