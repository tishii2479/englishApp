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
    
    var body: some View {
        UITableView.appearance().separatorStyle = .none
        return ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            
            GeometryReader { fullView in
                VStack {
                    CustomNavigationBar(hasReturn: true, hasSetting: true, title: "問題集")
                    
                    List {
                        ForEach(UserSetting.workbookCategories.indices) { index in
                            Section(header:
                                SectionHeader(title: UserSetting.workbookCategories[index].title)
                            ) {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack {
                                        ForEach (UserSetting.workbookArray[UserSetting.workbookCategories[index].title]!, id: \.bookId) { workbook in
                                            GeometryReader { geometry in
                                                NavigationLink(destination: WorkbookView(workbookViewModel: WorkbookViewModel(workbook: workbook))) {
                                                    WorkbookCellView(workbook: workbook)
                                                }
                                                .rotation3DEffect(.degrees(min(Double((geometry.frame(in: .global).minX - fullView.size.width / 2) / -5), 0)), axis: (x: 0, y: 1, z: 0))
                                                .buttonStyle(ShrinkButtonStyle())
                                            }
                                            .frame(width: 200, height: 200)
                                        }
                                    }
                                    .padding(.trailing, 50)
                                    .padding(.leading, 30)
                                }.padding(.horizontal, -30)
                            }
                        }
                    }.padding(.top, 20)
                }
            }
            
        }
        .navigationBarHidden(true)
        .navigationBarTitle("")
    }
}

struct WorkbookCollectionView_Previews: PreviewProvider {
    
    static var previews: some View {
        WorkbookCollectionView()
    }
}
