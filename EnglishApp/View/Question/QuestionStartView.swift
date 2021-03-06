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
        ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
                .onAppear(perform: {
                    self.questionViewModel.startSolving()
                })
        }
    }
}

struct QuestionStartView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionStartView(questionViewModel: QuestionViewModel(category: Category(), workbook: Workbook(), solveMode: .onlyNew))
    }
}
