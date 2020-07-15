//
//  QuestionSolveView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/01.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct QuestionSolveView: View {
    
    @ObservedObject var questionViewModel: QuestionViewModel
    
    var body: some View {
        VStack {
            // Timer
            HStack {
                // TimerBar
                GeometryReader{ geometry in
                    RoundedRectangle(cornerRadius: 10)
                        // FIXME: 長さを計算するか他の方法で直す必要あり
                        .frame(width: geometry.size.width * CGFloat(self.questionViewModel.remainingTime / self.questionViewModel.maxTime), height: 20, alignment: .leading)
                        .foregroundColor(self.questionViewModel.progressBarColor)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                        .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                        .animation(.easeIn)
                        Spacer()
                }.frame(maxHeight: 20)
            }.padding(10)
            
            HStack {
                // RemainingTime
                Text(String(format: "%.1f", questionViewModel.remainingTime))
                    .foregroundColor(Color.gray)

                Spacer()
                
                // PauseButton
                Button(action: {
                    // TODO: 一時停止処理
                    self.questionViewModel.pauseSolving()
                }) {
                    ZStack {
                        Circle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color.offWhite)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                        Image(systemName: "pause")
                            .frame(width: 40, height: 40)
                    }
                }.buttonStyle(ShrinkButtonStyle())
            }.padding(.horizontal, 10)
            
            // QuestionText
            Spacer()
            Text(self.questionViewModel.nowQuestion.questionText)
                .padding(10)
            Spacer()
            
            // ProgressBar
            HStack {
                Spacer()
                Text(String(self.questionViewModel.nowQuestionNum + 1))
                    .foregroundColor(Color.gray)
                    .font(.largeTitle)
                +
                Text("/" + String(self.questionViewModel.maxQuestionNum))
                    .foregroundColor(Color.gray)
            }.padding([.horizontal], 20)
            
            // ChoiceWindow
            ForEach(0 ..< 4) { (index) in
                ChoiceButtonView(questionViewModel: self.questionViewModel, index: index)
            }
        }
        .padding(.bottom, 10)
        .background(
            questionViewModel.backgroundColor
                .edgesIgnoringSafeArea(.all)
                .animation(.spring()))
    }
}

struct QuestionSolveView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionSolveView(questionViewModel: QuestionViewModel(workbook: Workbook(), solveMode: .onlyNew))
    }
}
