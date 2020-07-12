//
//  ProgressCircle.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/04.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct ProgressCircle: View {
    
    var text: String
    
    var radius: CGFloat
    
    var solveNumber: Int
    
    var maxNumber: Int
    
    var body: some View {
        ZStack {
            
            DentCircle(radius: radius + 10)
            
//            Circle()
//                .trim(from: 0, to: CGFloat(solveNumber) / CGFloat(maxNumber))
//                .stroke(Color.offWhite, style: StrokeStyle(lineWidth: 20, lineCap: .round))
//                .rotationEffect(Angle(degrees: -90), anchor: .center)
//                .frame(width: radius, height: radius)
//                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
//                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            
            VStack {
                Text(text)
                    .font(.caption)
                    .padding(10)

                Text(String(solveNumber))
                    .font(.largeTitle)
                +
                Text("/" + String(maxNumber))
            }
        }
        
    }
}

struct ProgressCircle_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            ProgressCircle(text: "解いた問題数", radius: 300, solveNumber: 20, maxNumber: 50)
        }
    }
}
