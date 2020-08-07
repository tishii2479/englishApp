//
//  QuestionBackView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/08/04.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct QuestionBackView: View {
    
    @Environment(\.presentationMode) var presentation: Binding<PresentationMode>
    
    @ObservedObject var questionViewModel: QuestionViewModel
    
    @State var showStartButton: Bool = true
    
    var body: some View {
        ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
        }.onAppear(perform: {
            self.presentation.wrappedValue.dismiss()
        })
    }
}

struct QuestionBackView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionBackView(questionViewModel: QuestionViewModel(category: Category(), workbook: Workbook(), solveMode: .all))
    }
}
