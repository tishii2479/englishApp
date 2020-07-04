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
    
    var body: some View {
        ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {    // のちにGridを用いたcollectionViewに変える、しないと増えた時に重い
                ForEach(0 ..< 10) { _ in
                    HStack {
                        ForEach(0 ..< 2) { _ in
                            NavigationLink(
                                destination: WorkbookView(workbookViewModel: WorkbookViewModel(workbook: Workbook()))
                            ) {
                                WorkbookCellView(workbookModel: Workbook())
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
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
