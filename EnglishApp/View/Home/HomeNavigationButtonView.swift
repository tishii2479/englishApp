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
            NavigationLink(destination: QuestionView(questionViewModel: QuestionViewModel(workbook:homeViewModel.getTodayWorkbook(), solveMode: .random))) {
                Text("ランダムに解く")
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
