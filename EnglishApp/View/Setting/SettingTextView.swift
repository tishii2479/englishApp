//
//  SettingTextView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/18.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct SettingTextView: View {
    
    var content: String
    
    var body: some View {
        ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            
            ScrollView  {
                Text(content)
                    .font(.subheadline)
                    .fontWeight(.light)
                    .lineLimit(nil)
                    .padding(20)
            }
        }
    }
}

struct SettingTextView_Previews: PreviewProvider {
    static var previews: some View {
        SettingTextView(content: "Hello")
    }
}
