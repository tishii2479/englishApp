//
//  ShopButtonView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/08/08.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct ShopButtonView: View {
    @State var isPresented: Bool = false
    
    var body: some View {
        Button(action: {
            self.isPresented.toggle()
        }) {
            ZStack {
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color.offWhite)
                
                Image(systemName: "cart")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.offBlack)
            }
        }
        .sheet(isPresented: $isPresented) {
            ShopView(isPresented: self.$isPresented)
        }
    }
}

struct ShopButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ShopButtonView()
    }
}
