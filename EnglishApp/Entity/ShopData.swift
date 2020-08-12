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
        ShopItem(itemId: "com.tishii2479.EnglishApp.consumable.coin50", title: "コイン×50", detail: "100問分です", price: 120),
        ShopItem(itemId: "com.tishii2479.EnglishApp.consumable.coin500", title: "コイン×250", detail: "500問分です", price: 490),
        ShopItem(itemId: "com.tishii2479.EnglishApp.consumable.coin800", title: "コイン×800", detail: "1600問分です", price: 1480),
        ShopItem(itemId: "com.tishii2479.EnglishApp.consumable.coin1700", title: "コイン×1700", detail: "3400問分です", price: 2940),
        ShopItem(itemId: "com.tishii2479.EnglishApp.consumable.coin3000", title: "コイン×3000", detail: "6000問分です", price: 4900),
    ]
}
