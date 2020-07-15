//
//  ChoiceButtonView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/06/30.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct ChoiceButtonView: View {
    
    @ObservedObject var questionViewModel: QuestionViewModel
    
    var index: Int
    
    var body: some View {
        Button(action: {
            self.questionViewModel.sendUserChoice(choice: self.getQuestionChoice(index: self.index))
        }) {
            Text(self.getQuestionChoice(index: self.index))
                .foregroundColor(Color.offBlack)
        }
        .buttonStyle(WideButtonStyle())
    }
    
    private func getQuestionChoice(index: Int) -> String {
        switch index {
        case 0:
            return self.questionViewModel.nowQuestion.choice1
        case 1:
            return self.questionViewModel.nowQuestion.choice2
        case 2:
            return self.questionViewModel.nowQuestion.choice3
        case 3:
            return self.questionViewModel.nowQuestion.choice4
        default:
            fatalError("invalid choice index")
        }
    }
}

struct ChoiceButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ChoiceButtonView(questionViewModel: QuestionViewModel(workbook: Workbook(), solveMode: .onlyNew), index: 0)
    }
}
