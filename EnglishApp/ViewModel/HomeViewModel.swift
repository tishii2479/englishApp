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
        // TODO: ここで今日の問題を日にちから取得する
        // 取得できなければそれを伝える
        return Workbook()
    }
    
}
