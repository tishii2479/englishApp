//
//  HomeView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/04.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var homeViewModel: HomeViewModel
    
    // ISSUE:
    // QuestionViewModelは複数箇所で生成されることがあり、そうなるのenvironmentObjectに指定した時に
    // 最初のインスタンスしか認められなくなってしまうため、インスタンスは常にこれを使う
    // あまり好ましくないため、改善が望ましい
    static var questionViewModel: QuestionViewModel = QuestionViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.offWhite
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    ProgressCircle(text: "今日解いた問題数", radius: homeViewModel.radius, solveNumber: homeViewModel.progress, maxNumber: homeViewModel.max)
                        
                    Spacer()
                    
                    // Details
                    HomeDetailTextView(itemName: "正解率", amount: String(78.5), unit: "%")
                    HomeDetailTextView(itemName: "解いた問題数", amount: String(120), unit: "問")
                    HomeDetailTextView(itemName: "完了した問題集", amount: String(1), unit: "個")
                    
                    Spacer()
                    
                    // Buttons
                    NavigationLink(destination: QuestionView().environmentObject(HomeView.questionViewModel)) {
                        Text("今日の10問")
                            .foregroundColor(Color.black)
                    }.buttonStyle(WideButtonStyle())

                    NavigationLink(destination: WorkbookCollectionView()) {
                        Text("問題集を解く")
                    }.buttonStyle(WideButtonStyle())
                    
                    Spacer()
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(trailing: SettingButtonView())
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(homeViewModel: HomeViewModel())
    }
}
