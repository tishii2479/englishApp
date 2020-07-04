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
    
    @Environment(\.presentationMode) var presentation: Binding<PresentationMode>
    
    var body: some View {
        
        ZStack {
            // Background
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            
            // ContentView
            contentView()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: ReturnButtonView(presentation: presentation))
    }
    
    // ISSUE: QuestionSolveViewはsome Viewでビルドは通ったが、
    // それ以外が通らないのでAnyViewで通している、理由は不明
    func contentView() -> AnyView {
        switch questionViewModel.status {
        case .start:
            return AnyView(QuestionStartView())
        case .solve:
            return AnyView(QuestionSolveView())
        case .result:
            return AnyView(QuestionResultView())
        case .pause:
            return AnyView(QuestionPauseView())
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
    }
}
