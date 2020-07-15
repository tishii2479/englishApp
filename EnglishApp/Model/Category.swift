//
//  Category.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/15.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var title: String = ""
    
    init(title: String) {
        self.title = title
    }
    
    required init() {}
    
}
