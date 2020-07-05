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
    
    @ObservedObject var user: User = UserSetting.user
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.offWhite
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    ProgressCircle(text: "今日解いた問題数", radius: 200, solveNumber: user.todayCorrectCount + user.todayMissCount, maxNumber: UserSetting.onedayQuota)
                        
                    Spacer()
                    // Details
                    HomeDetailTextView(itemName: "正解率", amount: user.correctRatioFormatter(correct: user.totalCorrectCount, miss: user.totalMissCount), unit: "%")
                    HomeDetailTextView(itemName: "解いた問題数", amount: String(user.totalCorrectCount + user.totalMissCount), unit: "問")
                    HomeDetailTextView(itemName: "完了した問題集", amount: String(user.completedWorkbookCount), unit: "個")
                    
                    Spacer()
                    
                    // Buttons
                    HomeNavigationButtonView()
                    
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
