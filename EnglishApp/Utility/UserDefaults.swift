//
//  UserDefaults.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/05.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import Foundation

extension UserDefaults {
    func removeAll() {
        dictionaryRepresentation().forEach { removeObject(forKey: $0.key) }
    }
}
