//
//  SectionHeader.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/15.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct SectionHeader: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.subheadline)
            .fontWeight(.bold)
            .padding(.horizontal, 30)
            .frame(width: UIScreen.main.bounds.width, height: 40,alignment: .leading)
            .background(Color.offWhite)
    }
}

struct SectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        SectionHeader(title: "セクション名")
    }
}
