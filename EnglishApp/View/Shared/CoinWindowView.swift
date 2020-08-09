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
    
    var body: some View {
        HStack {
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 100, height: 40)
                    .foregroundColor(Color.offWhite)
                    .shadow(color: Color.black.opacity(0.2), radius: 7, x: 7, y: 7)
                    .shadow(color: Color.white.opacity(0.7), radius: 7, x: -3, y: -3)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 20)
//                            .strokeBorder(Color.gray, lineWidth: 4)
//                            .frame(width: 100, height: 40)
//                            .blur(radius: 4)
//                            .offset(x: 2, y: 2)
//                            .mask(RoundedRectangle(cornerRadius: 20)
//                                    .fill(LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]), startPoint: .topLeading, endPoint: .bottomTrailing)))
//                                    .frame(width: 100, height: 40)
//                    )
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 20)
//                            .strokeBorder(Color.white, lineWidth: 4)
//                            .blur(radius: 4)
//                            .offset(x: -2, y: -2)
//                            .mask(RoundedRectangle(cornerRadius: 20)
//                                .fill(LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)))
//                                .frame(width: 100, height: 40)
//                    )
                
                HStack {
                    Image(systemName: "dollarsign.circle")
                        .resizable()
                        .frame(width: 24, height: 24)
                    
                    Spacer()
                    
                    Text(String(coin))
                }.frame(width: 80, height: 40)
            }
            
        }
        .padding(20)
        .padding(.top, 40)
    }
}

struct CoinWindowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinWindowView(coin: 100)
    }
}
