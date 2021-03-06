//
//  WorkbookView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/04.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct WorkbookView: View {
    
    @ObservedObject var workbookViewModel: WorkbookViewModel
    
    @Binding var isShowingTabBar: Bool
    
    @State var isShowingPurchaseAlert: Bool = false
 
    @State var isAbleToPurchase: Bool = false
    
    @State var isPresentedShop: Bool = false
    
    var category: Category
    
    var user: User = User.shared
    
    var body: some View {
        let workbook = self.workbookViewModel.workbook!
        let hasNewQuestions: Bool = workbook.correctCount + workbook.missCount < workbook.questionNumber
        let hasMissQuestions: Bool = workbook.missCount > 0
        
        return ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                CustomNavigationBar(hasReturn: true, hasSetting: false, hasShop: true, title: workbookViewModel.workbook.title)
                
                Spacer()
                
                ProgressCircleView(text: "解いた問題数", radius: UIScreen.main.bounds.width * CGFloat(0.5), solveNumber: workbookViewModel.workbook.correctCount, maxNumber: workbookViewModel.workbook.questionNumber)
                    .padding(.top, 10)

                // Liked
                HStack {
                    Spacer()

                    if self.workbookViewModel.workbook.likeCount > 0 {
                        NavigationLink(destination: QuestionView(questionViewModel: QuestionViewModel(category: category, workbook: workbook, solveMode: .liked))) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: 80, height: 40)
                                    .foregroundColor(Color.offWhite)
                                    .shadow(color: Color.black.opacity(0.2), radius: 7, x: 7, y: 7)
                                    .shadow(color: Color.white.opacity(0.7), radius: 7, x: -3, y: -3)

                                Image(systemName: "star.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                        }
                        .buttonStyle(ShrinkButtonStyle())
                    }

                }
                .frame(height: 40)
                .padding(.horizontal, 20)
                
                
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
                            Text(WorkbookFormatter.formatStatus(isPurchased: workbookViewModel.workbook.isPurchased, isPlayable: workbookViewModel.workbook.isPlayable))
                                .font(.caption)
                        }
                    }.padding(20)
                }
                
                Spacer()
                
                // Buttons
                Group {
                    if workbook.isPlayable == false {
                        Text("この問題集はまだ利用できません。\nこの問題集以前の問題集を完了してください。")
                            .multilineTextAlignment(.center)
                            .font(.subheadline)
                            .padding(10)
                    }
                    else if workbook.isPurchased == false {
                        Button(action: {
                            if self.user.coin >= workbook.price {
                                self.isAbleToPurchase = true
                            } else {
                                self.isAbleToPurchase = false
                            }
                            self.isShowingPurchaseAlert.toggle()
                        }) {
                            Text("購入する")
                        }
                        .buttonStyle(WideButtonStyle())
                        .alert(isPresented: self.$isShowingPurchaseAlert) {
                            if self.isAbleToPurchase {
                                return Alert(title: Text("問題集の購入"), message: Text("「\(workbook.title) (\(workbook.price)コイン)」を購入しますか？"), primaryButton: .default(Text("購入する"), action: {
                                    self.workbookViewModel.workbook.purchase()
                                }), secondaryButton: .cancel(Text("キャンセル")))
                            } else {
                                return Alert(title: Text("コインが足りません"), primaryButton: .default(Text("ショップへ"), action: {
                                    self.isPresentedShop.toggle()
                                }), secondaryButton: .cancel(Text("キャンセル")))
                            }
                        }
                        .sheet(isPresented: self.$isPresentedShop) {
                            ShopView(isPresented: self.$isPresentedShop)
                        }
                    
                    }
                    else if workbook.isCleared {
                        VStack {
                            NavigationLink(destination: QuestionView(questionViewModel: QuestionViewModel(category: category, workbook: workbookViewModel.workbook, solveMode: .all))) {
                                Text("総復習をする")
                            }.buttonStyle(WideButtonStyle())
                            
                            Group {
                                if hasMissQuestions {
                                    NavigationLink(destination: QuestionView(questionViewModel: QuestionViewModel(category: category, workbook: workbookViewModel.workbook, solveMode: .onlyMissed))) {
                                        Text("間違えた問題を復習する")
                                    }.buttonStyle(WideButtonStyle())
                                }
                            }
                        }
                    } else if hasNewQuestions {
                        VStack {
                            NavigationLink(destination: QuestionView(questionViewModel: QuestionViewModel(category: category, workbook: workbookViewModel.workbook, solveMode: .onlyNew))) {
                                Text("新しい問題を解く")
                            }.buttonStyle(WideButtonStyle())
                            
                            Group {
                                if hasMissQuestions {
                                    NavigationLink(destination: QuestionView(questionViewModel: QuestionViewModel(category: category, workbook: workbookViewModel.workbook, solveMode: .onlyMissed))) {
                                        Text("間違えた問題を復習する")
                                    }.buttonStyle(WideButtonStyle())
                                }
                            }
                        }
                    } else {
                        VStack {
                            NavigationLink(destination: QuestionView(questionViewModel: QuestionViewModel(category: category, workbook: workbookViewModel.workbook, solveMode: .test))) {
                                Text("確認テストを受ける")
                                    .foregroundColor(Color.offRed)
                            }.buttonStyle(WideButtonStyle())
                            
                            Group {
                                if hasMissQuestions {
                                    NavigationLink(destination: QuestionView(questionViewModel: QuestionViewModel(category: category, workbook: workbookViewModel.workbook, solveMode: .onlyMissed))) {
                                        Text("間違えた問題を復習する")
                                    }.buttonStyle(WideButtonStyle())
                                }
                            }
                        }
                    }
                }
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
        .navigationBarTitle("")
        .onAppear {
            self.isShowingTabBar = false
            self.workbookViewModel.updateView()
        }
    }
}

struct WorkbookView_Previews: PreviewProvider {
    static var previews: some View {
        WorkbookView(workbookViewModel: WorkbookViewModel(workbook: Workbook()), isShowingTabBar: Binding.constant(false), category: Category())
    }
}
