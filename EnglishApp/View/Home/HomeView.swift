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
    
    @ObservedObject var user: User = User.shared
    
    @Binding var isShowingTabBar: Bool
    
    var body: some View {
        return NavigationView {
            ZStack {
                Color.offWhite
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    CustomNavigationBar(hasReturn: false, hasSetting: true, hasShop: false, title: "")
                    
                    CoinWindowView(coin: user.coin)
                        .padding(.bottom, 20)
                    
                    ProgressCircleView(text: "今日解いた問題数", radius: UIScreen.main.bounds.width * CGFloat(0.6), solveNumber: user.todayCorrectCount + user.todayMissCount, maxNumber: user.onedayQuota)
                        
                    Spacer()
                    // Details
                    HomeDetailTextView(itemName: "正解率", amount: user.correctRatioFormatter(), unit: "%")
                    HomeDetailTextView(itemName: "解いた問題数", amount: String(user.totalCorrectCount + user.totalMissCount), unit: "問")
                    HomeDetailTextView(itemName: "完了した問題集", amount: String(user.completedWorkbookCount), unit: "個")
                    
                    Spacer()
                }
                .padding(.bottom, 80)
            }
            .navigationBarHidden(true)
            .navigationBarTitle("")
            .onAppear {
                self.isShowingTabBar = true
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(homeViewModel: HomeViewModel(), isShowingTabBar: Binding.constant(true))
    }
}
