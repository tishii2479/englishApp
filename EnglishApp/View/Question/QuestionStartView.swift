//
//  QuestionStartView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/01.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct QuestionStartView: View {
    
    @Environment(\.presentationMode) var presentation: Binding<PresentationMode>
    
    @ObservedObject var questionViewModel: QuestionViewModel
    
    @State var showStartButton: Bool = true
    
    var body: some View {
        VStack {
            CustomNavigationBar(hasReturn: true, hasSetting: false, title: "")
            
            Spacer()
            
            ZStack {
                DentCircleView(radius: 280)
                
                VStack {
                    Text(questionViewModel.workbook.title)
                        .padding()
                    Text(questionViewModel.workbook.detail)
                        .font(.subheadline)
                        .fontWeight(.ultraLight)
                        .padding()
                }
            }
            
            Spacer()
            Spacer()
            
            Group {
                if self.showStartButton {
                    Button(action: {
                        self.questionViewModel.startSolving()
                    }) {
                        Text("学習を始める")
                    }
                    .buttonStyle(WideButtonStyle())
                    .padding(.bottom, 50)
                } else {
                    // TODO: 内容をもう少し丁寧に、できれば戻る動作を入れる
                    Text("新しい問題はもうありません")
                }
            }
            
            Spacer()

        }.onAppear {
            // TODO: 問題の共有ができていないため、毎回取得し直している
            // 今後処理が多くて困るかもしれない
            self.questionViewModel.fetchQuestions()
            
            if self.questionViewModel.questions.count == 0 {
                // 問題が一つも存在しないため、問題を解けなくする
                self.showStartButton = false
            }
        }
    }
}

struct QuestionStartView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionStartView(questionViewModel: QuestionViewModel(workbook: Workbook(), solveMode: .onlyNew))
    }
}
