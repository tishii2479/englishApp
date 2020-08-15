//
//  CoinWindowView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/08/09.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct CoinWindowView: View {
    
    var coin: Int
    
    @State var isPresentedShop: Bool = false
    
    var body: some View {
        HStack {
            Spacer()

            Button(action: {
                self.isPresentedShop.toggle()
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 100, height: 40)
                        .foregroundColor(Color.offWhite)
                        .shadow(color: Color.black.opacity(0.2), radius: 7, x: 7, y: 7)
                        .shadow(color: Color.white.opacity(0.7), radius: 7, x: -3, y: -3)
                    
                    HStack {
                        Image(systemName: "dollarsign.circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                        
                        Spacer()
                        
                        Text(String(coin))
                    }.frame(width: 80, height: 40)
                }
            }
            .sheet(isPresented: $isPresentedShop) {
                ShopView(isPresented: self.$isPresentedShop)
            }
            .buttonStyle(ShrinkButtonStyle())
                
            
        }
        .padding([.top, .horizontal], 20)
    }
}

struct CoinWindowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinWindowView(coin: 100)
    }
}
