//
//  ShopItem.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/08/08.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import Foundation

class ShopItem {
    
    var itemId: String
    
    var title: String
    
    var detail: String
    
    var price: Int
    
    init (itemId: String, title: String, detail: String, price: Int) {
        self.itemId = itemId
        self.title = title
        self.detail = detail
        self.price = price
    }
    
}
