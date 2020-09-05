//
//  SettingButtonView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/04.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct SettingButtonView: View {
    
    @State var isPresented: Bool = false
    
    var body: some View {
        Button(action: {
            self.isPresented.toggle()
        }) {
            ZStack {
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color.offWhite)
                
                Image(systemName: "line.horizontal.3")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.offBlack)
            }
        }
        .sheet(isPresented: $isPresented) {
            SettingView(isPresented: self.$isPresented)
        }
    }
}

struct SettingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            
            SettingButtonView()
        }
    }
}
