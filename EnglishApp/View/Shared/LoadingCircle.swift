//
//  LoadingCircle.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/08/08.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct LoadingCircle: View {
    var body: some View {
        ZStack {
            Color.offBlack.opacity(0.2)
                .edgesIgnoringSafeArea(.all)
                .frame(height: UIScreen.main.bounds.height)
            
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.offBlack.opacity(0.6))
                .frame(width: 100, height: 100)
        }
    }
}

struct LoadingCircle_Previews: PreviewProvider {
    static var previews: some View {
        LoadingCircle()
    }
}
