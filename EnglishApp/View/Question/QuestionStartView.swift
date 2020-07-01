//
//  QuestionStartView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/01.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct QuestionStartView: View {
    
    @EnvironmentObject var questionViewModel: QuestionViewModel
    
    var body: some View {
        VStack {
            Text("Start")
            Button(action: {
                self.questionViewModel.startSolving()
            }) {
                Text("始める")
            }.buttonStyle(WideButtonStyle())
        }
    }
}

struct QuestionStartView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionStartView()
    }
}
