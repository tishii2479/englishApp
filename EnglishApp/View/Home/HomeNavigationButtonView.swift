//
//  HomeNavigationButtonView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/05.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct HomeNavigationButtonView: View {
    
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        VStack {
            // TODO: 今日の10問用のworkbookIdの取得
            NavigationLink(destination: QuestionView(questionViewModel: QuestionViewModel(workbook: homeViewModel.getTodayWorkbook(), solveMode: .onlyNew))) {
                Text("今日の10問")
                    .foregroundColor(Color.black)
            }.buttonStyle(WideButtonStyle())

            NavigationLink(destination: WorkbookCollectionView()) {
                Text("問題集を解く")
            }.buttonStyle(WideButtonStyle())
        }
    }
}

struct HomeNavigationButtonView_Previews: PreviewProvider {
    static var previews: some View {
        HomeNavigationButtonView(homeViewModel: HomeViewModel())
    }
}
