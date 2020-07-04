//
//  HomeDetailTextView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/04.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct HomeDetailTextView: View {
    
    var itemName: String
    
    var amount: String
    
    var unit: String
    
    
    var body: some View {
        ZStack(alignment: .trailing) {
            HStack(alignment: .firstTextBaseline) {
                Spacer()

                Text(itemName)
                Group {
                    Text(amount)
                        .font(.largeTitle)
                    +
                    Text(unit)
                }.frame(width: 120, height: 40, alignment: .trailing)
            }
            .padding(.trailing, 20)
            .padding(.top, 10)
        }
    }
}

struct HomeDetailTextView_Previews: PreviewProvider {
    static var previews: some View {
        HomeDetailTextView(itemName: "正解率", amount: "78.5", unit: "%")
    }
}
