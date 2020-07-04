//
//  QuestionPauseView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/01.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct QuestionPauseView: View {
    
    @ObservedObject var questionViewModel: QuestionViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            // nowQuestionNumとremainingTimeの表示
            Text(String(questionViewModel.nowQuestionNum + 1))
                .font(.system(size: 54))
            +
            Text(" / " + String(questionViewModel.maxQuestionNum))
                
            Text("残り時間　" + String(Int(questionViewModel.remainingTime)))
            
            Spacer()
            
            // Buttons
            Button(action: {
                self.questionViewModel.resumeSolving()
            }) {
                Text("再開する")
            }.buttonStyle(WideButtonStyle())
            
            Button(action: {
                self.questionViewModel.quitSolving()
            }) {
                Text("中止する")
                    .foregroundColor(Color.offRed)
            }.buttonStyle(WideButtonStyle())
            
            Spacer()
        }
    }
}

struct QuestionPauseView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionPauseView(questionViewModel: QuestionViewModel(workbook: Workbook()))
    }
}
