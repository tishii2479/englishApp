//
//  Color.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/06/30.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

extension Color {
    
    static func withColorCode(red: Double, green: Double, blue: Double) -> Color {
        return Color(red: red / 255, green: green / 255, blue: blue / 255)
    }
    
    static let offWhite = withColorCode(red: 225, green: 225, blue: 235)
    
    static let offBlack = withColorCode(red: 51, green: 51, blue: 51)
    
    static let offRed = withColorCode(red: 255, green: 132, blue: 132)
    
}
