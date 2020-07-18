//
//  PreviewCellView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/14.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct PreviewCellView: View {
    
    @State var isLiked: Bool = false
    
    var question: Question
    
    var userChoice: String
    
    var questionNum: Int
    
    var maxQuestionNum: Int
    
    var questionViewModel: QuestionViewModel
    
    var body: some View {
        return ZStack {
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color.offWhite)
                .frame(height: 320)
                .padding(10)
                .contentShape(RoundedRectangle(cornerRadius: 25).inset(by: 15))
                .shadow(color: Color.black.opacity(0.2), radius: 7, x: 7, y: 7)
                .shadow(color: Color.white.opacity(0.7), radius: 7, x: -4, y: -4)
            
            VStack {
                // 問題番号
                HStack {
                    Text(String(questionNum))
                        .font(.title)
                    +
                    Text("/" + String(maxQuestionNum))
                
                    Spacer()
                    
                    Button(action: {
                        self.isLiked.toggle()
                        self.question.changeIsLiked(isLiked: self.isLiked)
                        self.questionViewModel.workbook.updateCount(type: .like, amount: self.isLiked ? 1 : 0)
                    }) {
                        Image(systemName: self.isLiked ? "star.fill" : "star")
                            .frame(width: 30, height: 30)
                            .onAppear {
                                self.isLiked = self.question.isLiked
                            }
                    }.buttonStyle(ShrinkButtonStyle())
                }
                
                Spacer()
                
                // 問題文
                Text(question.questionText)
                    .font(.callout)
                
                Spacer()
                
                // 選択肢
                VStack {
                    HStack {
                        SmallChoiceView(choice: question.choice1, hasSelected: userChoice == question.choice1, isAnswer: question.answer == question.choice1)
                        SmallChoiceView(choice: question.choice2, hasSelected: userChoice == question.choice2, isAnswer: question.answer == question.choice2)
                    }
                    HStack {
                        SmallChoiceView(choice: question.choice3, hasSelected: userChoice == question.choice3, isAnswer: question.answer == question.choice3)
                        SmallChoiceView(choice: question.choice4, hasSelected: userChoice == question.choice4, isAnswer: question.answer == question.choice4)
                    }
                }
            }
            .frame(height: 280)
            .padding(25)
        }
        .frame(height: 350)
        .listRowBackground(Color.offWhite)
    }
}

struct PreviewCellView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            PreviewCellView(question: Question(), userChoice: "user", questionNum: 1, maxQuestionNum: 10, questionViewModel: QuestionViewModel(workbook: Workbook(), solveMode: .all))
        }
    }
}
