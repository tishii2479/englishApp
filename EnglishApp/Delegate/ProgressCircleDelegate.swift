//
//  ProgressCircleDelegate.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/04.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

protocol ProgressCircleDelegate {
    
    var progress: Int { get }
    var max: Int { get }
    var radius: CGFloat { get }
    
}
