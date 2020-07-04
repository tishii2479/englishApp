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

    let workbooks = UserSetting.workbookArray
    
    var body: some View {
        ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            
            QGrid(workbooks, columns: 2) { workbook in
                NavigationLink(destination: WorkbookView(workbookViewModel: WorkbookViewModel(workbook: workbook))) {
                    WorkbookCellView(workbook: workbook)
                }.buttonStyle(PlainButtonStyle())
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("問題集", displayMode: .inline)
        .navigationBarItems(leading: ReturnButtonView(presentation: presentation), trailing: SettingButtonView())
    }
}

struct WorkbookCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        WorkbookCollectionView()
    }
}
