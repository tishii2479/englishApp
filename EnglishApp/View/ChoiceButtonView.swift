//
//  ChoiceButtonView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/06/30.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct ChoiceButtonView: View {
    
    @EnvironmentObject var questionViewModel: QuestionViewModel
    
    var index: Int
    
    var body: some View {
        Button(action: {
            self.questionViewModel.sendUserChoice(choice: self.questionViewModel.nowQuestion.choices[self.index])
        }) {
            Text(self.questionViewModel.nowQuestion.choices[self.index])
                .foregroundColor(Color.offBlack)
        }
        .buttonStyle(WideButtonStyle())
    }
}

struct ChoiceButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ChoiceButtonView(index: 0)
    }
}
