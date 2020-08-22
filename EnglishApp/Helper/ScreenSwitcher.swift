//
//  ScreenSwitcher.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/08/22.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import Foundation
import SwiftUI

class ScreenSwitcher: ObservableObject {
    
    static let shared = ScreenSwitcher()
    
    @Published var isLoading: Bool = false
    
    @Published var loadingText: String = ""
    
    @Published var showLogin: Bool = false
    
}
