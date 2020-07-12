//
//  SettingCellView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/12.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct SettingCellView: View {
    
    enum ItemType {
        case button
        case detail
    }
    
    var title: String
    
    var body: some View {
        Text(title)
            .listRowBackground(Color.offWhite)
    }
}

struct SettingCellView_Previews: PreviewProvider {
    static var previews: some View {
        SettingCellView(title: "aa")
    }
}
