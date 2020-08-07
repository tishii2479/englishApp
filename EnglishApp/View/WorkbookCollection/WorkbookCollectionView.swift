//
//  WorkbookCollectionView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/04.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI
import QGrid

struct WorkbookCollectionView: View {
    
    @Environment(\.presentationMode) var presentation: Binding<PresentationMode>
    
    @Binding var isShowingTabBar: Bool
    
    var category: Category
    
    var body: some View {
        guard let workbookArr = UserSetting.workbookArray[category.title] else { fatalError() }
        return ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                CustomNavigationBar(hasReturn: true, hasSetting: true, title: category.title)
                
                QGrid(workbookArr,
                      columns: 2) { workbook in
                        NavigationLink(destination: WorkbookView(workbookViewModel: WorkbookViewModel(workbook: workbook), isShowingTabBar: self.$isShowingTabBar, category: self.category)) {
                            WorkbookCellView(workbook: workbook)
                        }.buttonStyle(ShrinkButtonStyle())
                }
                .edgesIgnoringSafeArea(.bottom)
            }
            .navigationBarHidden(true)
            .navigationBarTitle("")
            .onAppear {
                UITableView.appearance().separatorStyle = .none
                self.isShowingTabBar = false
            }
        }
    }
}

struct WorkbookCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        WorkbookCollectionView(isShowingTabBar: Binding.constant(true), category: Category())
    }
}
