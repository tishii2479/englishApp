//
//  QuestionResultView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/01.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct QuestionResultView: View {
    
    @ObservedObject var questionViewModel: QuestionViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("正解した問題数")
            
            // nowQuestionNumとremainingTimeの表示
            Text(String(questionViewModel.correctCount))
                .font(.system(size: 54))
            +
            Text(" / " + String(questionViewModel.maxQuestionNum))
                
            Text(String(format: "所要時間:  %.1f秒", questionViewModel.maxTime - questionViewModel.remainingTime))
                .fontWeight(.light)
                .padding(.vertical, 5)
            Text(String(format: "一問あたりの所要時間: %.1f秒", (questionViewModel.maxTime - questionViewModel.remainingTime) / Double(questionViewModel.maxQuestionNum)))
                .fontWeight(.light)
            
            Spacer()
            Spacer()
            
            // Buttons
            Button(action: {
                self.questionViewModel.startSolving()
            }) {
                Text("次の問題を解く")
            }.buttonStyle(WideButtonStyle())
            
            Button(action: {
                // TODO: 学習終了処理
                self.questionViewModel.quitSolving()
            }) {
                Text("学習を終了する")
                    .foregroundColor(.offRed)
            }
            .buttonStyle(WideButtonStyle())
            .padding(.bottom, 50)
        }
    }
}

struct QuestionResultView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionResultView(questionViewModel: QuestionViewModel(workbook: Workbook()))
    }
}
