//
//  ProgressCircleView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/04.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct ProgressCircleView: View {
    
    var text: String
    
    var radius: CGFloat
    
    var solveNumber: Int
    
    var maxNumber: Int
    
    var body: some View {
        ZStack {
            
            Circle()
                .stroke(Color.offWhite, style: StrokeStyle(lineWidth: 20))
                .rotationEffect(Angle(degrees: -90), anchor: .center)
                .frame(width: radius, height: radius)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            
            Circle()
                .trim(from: 0, to: CGFloat(solveNumber) / CGFloat(maxNumber))
                .stroke(Color.offRed, style: StrokeStyle(lineWidth: 20))
                .rotationEffect(Angle(degrees: -90), anchor: .center)
                .frame(width: radius, height: radius)
                .shadow(color: Color.offRed.opacity(0.5), radius: 8, x: 8, y: 8)
                .shadow(color: Color.offRed.opacity(0.7), radius: 8, x: -4, y: -4)
            
            VStack {
                Text(text)
                    .font(.caption)
                    .padding(.vertical, 10)

                Text(String(solveNumber))
                    .font(.largeTitle)
                +
                Text("/" + String(maxNumber))
            }
        }
        
    }
}

struct ProgressCircleView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            ProgressCircleView(text: "解いた問題数", radius: 300, solveNumber: 20, maxNumber: 50)
        }
    }
}
