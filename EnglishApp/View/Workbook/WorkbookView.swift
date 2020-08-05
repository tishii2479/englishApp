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
        let workbook = self.workbookViewModel.workbook!
        let hasNewQuestions: Bool = workbook.correctCount + workbook.missCount < workbook.questionNumber
        let hasMissQuestions: Bool = workbook.missCount > 0
        
        return ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                CustomNavigationBar(hasReturn: true, hasSetting: true, title: workbookViewModel.workbook.title)
                
                Spacer()
                
                ProgressCircleView(text: "解いた問題数", radius: 200, solveNumber: workbookViewModel.workbook.correctCount, maxNumber: workbookViewModel.workbook.questionNumber)
                
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
                Group {
                    if workbook.isCleared {
                        AnyView(
                            VStack {
                                NavigationLink(destination: QuestionView(questionViewModel: QuestionViewModel(workbook: workbookViewModel.workbook, solveMode: .all))) {
                                    Text("総復習をする")
                                }.buttonStyle(WideButtonStyle())
                                Group {
                                    if workbook.likeCount > 0 {
                                        NavigationLink(destination: QuestionView(questionViewModel: QuestionViewModel(workbook: workbookViewModel.workbook, solveMode: .liked))) {
                                            Text("お気に入りした問題を解く")
                                        }.buttonStyle(WideButtonStyle())
                                    }
                                }
                            }
                        )
                    } else if hasNewQuestions {
                        AnyView(
                            VStack {
                                NavigationLink(destination: QuestionView(questionViewModel: QuestionViewModel(workbook: workbookViewModel.workbook, solveMode: .onlyNew))) {
                                    Text("新しい問題を解く")
                                }.buttonStyle(WideButtonStyle())
                                
                                Group {
                                    if hasMissQuestions {
                                        NavigationLink(destination: QuestionView(questionViewModel: QuestionViewModel(workbook: workbookViewModel.workbook, solveMode: .onlyMissed))) {
                                            Text("間違えた問題を復習する")
                                        }.buttonStyle(WideButtonStyle())
                                    }
                                }
                            }
                        )
                    } else {
                        AnyView(
                            VStack {
                                NavigationLink(destination: QuestionView(questionViewModel: QuestionViewModel(workbook: workbookViewModel.workbook, solveMode: .test))) {
                                    Text("確認テストを受ける")
                                }.buttonStyle(WideButtonStyle())
                                
                                Group {
                                    if hasMissQuestions {
                                        NavigationLink(destination: QuestionView(questionViewModel: QuestionViewModel(workbook: workbookViewModel.workbook, solveMode: .onlyMissed))) {
                                            Text("間違えた問題を復習する")
                                        }.buttonStyle(WideButtonStyle())
                                    }
                                }
                            }
                        )
                    }
                }
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
        .navigationBarTitle("")
    }
}

struct WorkbookView_Previews: PreviewProvider {
    static var previews: some View {
        WorkbookView(workbookViewModel: WorkbookViewModel(workbook: Workbook()))
    }
}
