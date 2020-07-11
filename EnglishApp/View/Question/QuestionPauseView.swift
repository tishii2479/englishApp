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
                
            Text(String(format: "残り時間:  %.1f秒", questionViewModel.remainingTime))
                .fontWeight(.light)
                .padding(.vertical, 10)
            
            Spacer()
            
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
            }
            .buttonStyle(WideButtonStyle())
            .padding(.bottom, 50)
        }
    }
}

struct QuestionPauseView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionPauseView(questionViewModel: QuestionViewModel(workbook: Workbook()))
    }
}
