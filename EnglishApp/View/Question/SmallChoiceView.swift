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
        
        return GeometryReader { geometry in
            Text(self.choice)
                .font(.subheadline)
                .frame(width: geometry.size.width, height: 40)
                .padding(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(self.strokeColor(), lineWidth: 2)
                        .frame(width: geometry.size.width, height: 40)
                )
        }.frame(height: 40)
    }
    
    func strokeColor() -> Color {
        if hasSelected {
            return Color.offGreen
        } else if isAnswer {
            return Color.offRed
        } else {
            return Color.lightGray
        }
    }
}

struct SmallChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        SmallChoiceView(choice: "coice", hasSelected: false, isAnswer: false)
    }
}
