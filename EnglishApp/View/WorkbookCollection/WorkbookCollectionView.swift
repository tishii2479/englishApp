//
//  WorkbookCollectionView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/04.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct WorkbookCollectionView: View {
    
    @Environment(\.presentationMode) var presentation: Binding<PresentationMode>
    
    @Binding var isShowingTabBar: Bool
    
    var body: some View {
        UITableView.appearance().separatorStyle = .none
        
        return ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                CustomNavigationBar(hasReturn: false, hasSetting: true, title: "問題集")
                
                List {
                    ForEach(UserSetting.workbookCategories.indices) { index in
                        Section(header:
                            SectionHeader(title: UserSetting.workbookCategories[index].title)
                        ) {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach (UserSetting.workbookArray[UserSetting.workbookCategories[index].title]!, id: \.bookId) { workbook in
                                        NavigationLink(destination: WorkbookView(workbookViewModel: WorkbookViewModel(workbook: workbook), isShowingTabBar: self.$isShowingTabBar)) {
                                            WorkbookCellView(workbook: workbook)
                                        }
                                        .buttonStyle(ShrinkButtonStyle())
                                    }
                                    .frame(width: 180, height: 180)
                                }
                                .padding(.horizontal, 30)
                            }
                        }.padding(.horizontal, -30)
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
                self.isShowingTabBar = true
            }
        }
    }
}

struct WorkbookCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        WorkbookCollectionView(isShowingTabBar: Binding.constant(true))
    }
}
