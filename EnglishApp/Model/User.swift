//
//  User.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/05.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import Foundation

class User: ObservableObject {
 
    @Published var todayCorrectCount: Int = 0
    
    @Published var todayMissCount: Int = 0
    
    @Published var totalCorrectCount: Int = 40

    @Published var totalMissCount: Int = 10
    
    @Published var completedWorkbookCount: Int = 0
        
}
