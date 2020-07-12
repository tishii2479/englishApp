//
//  QuestionView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/06/30.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct QuestionView: View {
    
    @ObservedObject var questionViewModel: QuestionViewModel
    
    var body: some View {
        
        ZStack {
            // Background
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // ContentView
                contentView()
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    
    // ISSUE: QuestionSolveViewはsome Viewでビルドは通ったが、
    // それ以外が通らないのでAnyViewで通している、理由は不明
    func contentView() -> AnyView {
        switch questionViewModel.status {
        case .start:
            return AnyView(QuestionStartView(questionViewModel: questionViewModel))
        case .solve:
            return AnyView(QuestionSolveView(questionViewModel: questionViewModel))
        case .result:
            return AnyView(QuestionResultView(questionViewModel: questionViewModel))
        case .pause:
            return AnyView(QuestionPauseView(questionViewModel: questionViewModel))
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(questionViewModel: QuestionViewModel(workbook: Workbook()))
    }
}
