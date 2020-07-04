//
//  WorkbookView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/04.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct WorkbookView: View {
    
    @Environment(\.presentationMode) var presentation: Binding<PresentationMode>
    
    @ObservedObject var workbookViewModel: WorkbookViewModel
    
    var body: some View {
        ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Spacer()
                
                ProgressCircle(text: "解いた問題数", radius: 200, solveNumber: workbookViewModel.workbook.correctCount, maxNumber: workbookViewModel.workbook.questionNumber)
                
                Spacer()
                
                HStack {
                    VStack(alignment: .leading, spacing: 15) {
                        Text(workbookViewModel.workbook.title)
                            .font(.title)
                        
                        Text(workbookViewModel.workbook.detail)
                            .fontWeight(.ultraLight)
                        
                        Text(WorkbookFormatter.formatDifficult(difficulty: workbookViewModel.workbook.difficulty))
                            .font(.caption)
                        
                        HStack {
                            Text(WorkbookFormatter.formatQuestionNumber(number: workbookViewModel.workbook.questionNumber))
                                .font(.caption)
                            Spacer()
                            Text(WorkbookFormatter.formatStatus(isPurchased: workbookViewModel.workbook.isPurchased))
                                .font(.caption)
                        }
                    }.padding(20)
                }
                
                Spacer()
                
                // Buttons
                NavigationLink(destination: QuestionView().environmentObject(QuestionViewModel())) {
                    Text("新しい問題を解く")
                }.buttonStyle(WideButtonStyle())
                NavigationLink(destination: QuestionView().environmentObject(QuestionViewModel())) {
                    Text("間違えた問題を復習する")
                }.buttonStyle(WideButtonStyle())
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle(Text(workbookViewModel.workbook.title), displayMode: .inline)
        .navigationBarItems(leading: ReturnButtonView(presentation: presentation), trailing: SettingButtonView())
    }
}

struct WorkbookView_Previews: PreviewProvider {
    static var previews: some View {
        WorkbookView(workbookViewModel: WorkbookViewModel(workbook: Workbook()))
    }
}
