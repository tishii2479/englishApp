//
//  QuestionStartView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/01.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct QuestionStartView: View {
    
    @ObservedObject var questionViewModel: QuestionViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(questionViewModel.workbook.title)
                .font(.title)
                .padding()
            Text(questionViewModel.workbook.detail)
                .fontWeight(.light)
                .padding()
            
            Spacer()
            
            Button(action: {
                self.questionViewModel.startSolving()
            }) {
                Text("学習を始める")
            }.buttonStyle(WideButtonStyle())
            
            Spacer()
        }
    }
}

struct QuestionStartView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionStartView(questionViewModel: QuestionViewModel(workbook: Workbook()))
    }
}
