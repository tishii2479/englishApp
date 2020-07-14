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
        ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                CustomNavigationBar(hasReturn: true, hasSetting: true, title: "問題集")
            
                QGrid(UserSetting.workbookArray, columns: 2) { workbook in
                    NavigationLink(destination: WorkbookView(workbookViewModel: WorkbookViewModel(workbook: workbook))) {
                        WorkbookCellView(workbook: workbook)
                    }.buttonStyle(ShrinkButtonStyle())
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
