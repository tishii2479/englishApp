//
//  ShopData.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/08/08.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import Foundation

class ShopData {
    static let shopItems: [ShopItem] = [
        ShopItem(itemId: "1", title: "コイン×50", detail: "100問分です", price: 120),
        ShopItem(itemId: "2", title: "コイン×250", detail: "500問分です", price: 500),
        ShopItem(itemId: "4", title: "コイン×800", detail: "1600問分です", price: 1500),
        ShopItem(itemId: "5", title: "コイン×1700", detail: "3400問分です", price: 3000),
        ShopItem(itemId: "6", title: "コイン×3000", detail: "6000問分です", price: 5000),
    ]
}
