//
//  HomeViewModel.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/04.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var progress: Int = 20
    
    var max: Int = 50
    
    var radius: CGFloat = 200
    
}
