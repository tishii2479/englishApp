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
            Text("学習をします")
            
            Spacer()
            
            Button(action: {
                self.questionViewModel.startSolving()
            }) {
                Text("始める")
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
