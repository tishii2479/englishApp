//
//  ShopCellView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/08/08.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct ShopCellView: View {
    
    var item: ShopItem
    
    var body: some View {
        HStack {
            Image(systemName: "dollarsign.circle")
                .resizable()
                .frame(width: 50, height: 50)
            
            Spacer()
            
            VStack {
                HStack {
                    Text(item.title)
                    Spacer()
                }
                
                Spacer()
                
                HStack {
                    Text(item.detail)
                        .font(.subheadline)
                        .fontWeight(.light)
                    Spacer()
                }
            }
            .padding(10)
            
            Spacer()
            
            Button(action: {
                
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.offBlack)
                        .frame(width: 80, height: 30)
                        
                    
                    Text("¥\(item.price)")
                        .font(.subheadline)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .foregroundColor(.offWhite)
                }
            }
            .padding(.top, 30)
            .padding(.trailing, 10)
        }
        .frame(height: 80)
    }
}

struct ShopCellView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            
            List {
                ShopCellView(item: ShopItem(itemId: "aaa", title: "aaa", detail: "aaa", price: 120))
            }
        }
    }
}
