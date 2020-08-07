//
//  WorkbookGenreCollectionView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/08/07.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct WorkbookGenreCollectionView: View {
    
    @Binding var isShowingTabBar: Bool
    
    var body: some View {
        ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                CustomNavigationBar(hasReturn: false, hasSetting: true, title: "問題集一覧")
                
                ScrollView {
                    ForEach(UserSetting.workbookCategories, id: \.self) { category in
                        
                        NavigationLink(destination: WorkbookCollectionView(isShowingTabBar: self.$isShowingTabBar, category: category)) {
                            WorkbookGenreCellView(category: category)
                        }
                        .buttonStyle(ShrinkButtonStyle())
                    }
                    
                    // タブバーのための余白
                    Color.offWhite
                        .frame(height: 80)
                }
                .padding(.top, 20)
            }
            .navigationBarHidden(true)
            .navigationBarTitle("")
            .onAppear {
                UITableView.appearance().separatorStyle = .none
                self.isShowingTabBar = true
            }
        }
    }
}

struct WorkbookGenreCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        WorkbookGenreCollectionView(isShowingTabBar: Binding.constant(true))
    }
}
