//
//  QuestionView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/06/30.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct QuestionView: View {
    
    @EnvironmentObject var questionViewModel: QuestionViewModel
    
    @ObservedObject var questionTimerDelegate: QuestionTimerDelegate = QuestionTimerDelegate()
    
    var body: some View {
        ZStack {
            // Background
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
        
            // Content
            VStack {
                // Timer
                HStack {
                    // TimerBar
                    RoundedRectangle(cornerRadius: 10)
                        // FIXME: 長さを計算するか他の方法で直す必要あり
                        .frame(width: CGFloat(330 * self.questionTimerDelegate.remainingTime / self.questionTimerDelegate.maxTime), height: 20, alignment: .leading)
                        .foregroundColor(Color.offWhite)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                        .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                    Spacer()
                }.padding(.horizontal, 10)
                
                HStack {
                    // RemainingTime
                    Text(String(Int(self.questionTimerDelegate.remainingTime))) // TODO: 残り時間の表示形式
                        .foregroundColor(Color.gray)

                    Spacer()
                    
                    // PauseButton
                    Button(action: {
                        // TODO: 一時停止処理
                        self.questionTimerDelegate.pauseTimer()
                    }) {
                        Circle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color.offWhite)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                    }
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
                    ChoiceButtonView(index: index)
                }
            }
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
    }
}
