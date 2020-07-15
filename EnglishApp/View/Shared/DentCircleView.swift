//
//  DentCircleView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/12.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct DentCircleView: View {
    
    var radius: CGFloat
    
    var body: some View {
        Circle()
            .foregroundColor(Color.offWhite)
            .frame(width: radius + 10, height: radius + 10)
            .overlay(
                Circle()
                    .strokeBorder(Color.gray, lineWidth: 4)
                    .frame(width: radius + 10, height:radius + 10)
                    .blur(radius: 4)
                    .offset(x: 2, y: 2)
                    .mask(Circle()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]), startPoint: .topLeading, endPoint: .bottomTrailing)))
                            .frame(width: radius + 10, height: radius + 10)
            )
            .overlay(
                Circle()
                    .strokeBorder(Color.white, lineWidth: 4)
                    .frame(width: radius + 10, height:radius + 10)
                    .blur(radius: 4)
                    .offset(x: -2, y: -2)
                    .mask(Circle()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)))
                        .frame(width: radius + 10, height: radius + 10)
            )
    }
}

struct DentCircleView_Previews: PreviewProvider {
    static var previews: some View {
        DentCircleView(radius: 60)
    }
}
