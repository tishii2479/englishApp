//
//  SmallChoiceView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/14.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct SmallChoiceView: View {
    
    var choice: String
    
    var hasSelected: Bool
    
    var isAnswer: Bool
    
    var body: some View {
        GeometryReader { geometry in
            Text(self.choice)
                .font(.subheadline)
                .frame(width: geometry.size.width, height: 40)
                .padding(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(self.isAnswer ? Color.offBlue : Color.offBlack, lineWidth: 2)
                        .frame(width: geometry.size.width, height: 40)
                )
        }.frame(height: 40)
    }
}

struct SmallChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        SmallChoiceView(choice: "coice", hasSelected: false, isAnswer: false)
    }
}
