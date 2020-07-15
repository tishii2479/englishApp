//
//  QuestionReviewView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/14.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct QuestionReviewView: View {
    
    @Binding var isPresented: Bool
    
    var questionViewModel: QuestionViewModel
    
    var body: some View {
        UITableView.appearance().separatorStyle = .none
        
        return ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button(action: {
                        self.isPresented = false
                    }) {
                        Image(systemName: "multiply")
                            .resizable()
                            .frame(width: 15, height: 15)
                    }
                    .buttonStyle(ShrinkButtonStyle())
                    .frame(width: 30, height: 30)
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
            
                List {
                    ForEach(0 ..< questionViewModel.maxQuestionNum) { i in
                        // https://developer.apple.com/forums/thread/131577
                        VStack {
                            PreviewCellView(question: self.questionViewModel.questions[i], userChoice: self.questionViewModel.userChoices[i], questionNum: i + 1, maxQuestionNum: self.questionViewModel.maxQuestionNum)
                        }
                    }
                }
                .background(Color.offWhite)
            }
        }
    }
}

struct QuestionReviewView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionReviewView(isPresented: Binding.constant(true), questionViewModel: QuestionViewModel(workbook: Workbook(), solveMode: .onlyNew))
    }
}
