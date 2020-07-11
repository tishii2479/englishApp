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

    static func fetchAllDatas<T>() -> Results<T>? where T: Object  {
       
       do {
           let realm = try Realm()
           let datas = realm.objects(T.self)
           
           return datas
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
    
}
