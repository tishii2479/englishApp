//
//  QuestionResultView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/01.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct QuestionResultView: View {
    
    @EnvironmentObject var questionViewModel: QuestionViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("正解した問題数")
            
            // nowQuestionNumとremainingTimeの表示
            Text(String(questionViewModel.correctCount))
                .font(.system(size: 54))
            +
            Text(" / " + String(questionViewModel.maxQuestionNum))
                
            Text("所要時間　" + String(Int(questionViewModel.maxTime - questionViewModel.remainingTime)))
            
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

struct QuestionResultView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionResultView()
    }
}
