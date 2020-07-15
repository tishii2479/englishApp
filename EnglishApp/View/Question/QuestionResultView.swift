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
    
    @State var isPresented: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                DentCircleView(radius: 320)
                
                VStack {
                    Text("正解した問題数")
                        .font(.subheadline)
                    
                    // nowQuestionNumとremainingTimeの表示
                    Text(String(questionViewModel.correctCount))
                        .font(.system(size: 54))
                    +
                    Text(" / " + String(questionViewModel.maxQuestionNum))
                        
                    Text(String(format: "所要時間:  %.1f秒", questionViewModel.totalTime))
                        .font(.subheadline)
                        .fontWeight(.light)
                        .padding(.vertical, 5)
                    Text(String(format: "一問あたり: %.1f秒", questionViewModel.totalTime / Double(questionViewModel.maxQuestionNum)))
                        .font(.subheadline)
                        .fontWeight(.light)
                        
                    Button(action: {
                        self.isPresented.toggle()
                    }) {
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color.offWhite)
                                .frame(width: 200, height: 40)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
                                .shadow(color: Color.white.opacity(0.7), radius: 5, x: -3, y: -3)
                                
                            Text("答えを見る")
                        }
                    }
                    .buttonStyle(ShrinkButtonStyle())
                    .sheet(isPresented: $isPresented) {
                        QuestionReviewView(isPresented: self.$isPresented, questionViewModel: self.questionViewModel)
                    }
                    .padding(.top, 15)
                }
            }
                
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
        QuestionResultView(questionViewModel: QuestionViewModel(workbook: Workbook(), solveMode: .onlyNew))
    }
}
