//
//  SettingView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/04.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    
    @Environment(\.presentationMode) var presentation: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                CustomNavigationBar(hasReturn: true, hasSetting: false, title: "設定")
                
                List {
                    ForEach(0 ..< 5) { index in
                        SettingCellView(title: "設定項目\(index)")
                    }
                }.padding(.top, 10)
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
        .navigationBarTitle("")
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
