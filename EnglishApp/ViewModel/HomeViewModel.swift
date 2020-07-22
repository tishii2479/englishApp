//
//  HomeViewModel.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/04.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var user: User = User.shared
    
    func getTodayWorkbook() -> Workbook {
        return Workbook(bookId: "0", title: "ランダム問題集", detail: "難易度はランダムです。", category: "0", difficulty: 0, questionNumber: User.shared.maxQuestionNum, price: 0, correctCount: 0, missCount: 0, isPurchased: true, isCleared: false)
    }
    
}
