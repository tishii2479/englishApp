//
//  ReturnButtonView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/04.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct ReturnButtonView: View {
    
    var presentation: Binding<PresentationMode>
    
    var body: some View {
        Button(action: {
            self.presentation.wrappedValue.dismiss()
        }) {
            ZStack {
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color.offWhite)
                
                Image(systemName: "arrow.uturn.left")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.offBlack)
            }
        }
    }
}
