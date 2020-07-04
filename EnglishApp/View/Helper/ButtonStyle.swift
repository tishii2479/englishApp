//
//  ButtonStyle.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/06/30.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct WideButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        // FIXME: ContentShapeが実際の大きさより大きく認識されている
        // ZStackで当たり判定を重ねるか、大きさを変えれば良いの
        // https://capibara1969.com/1927/より、strokeを使うと判定が大きくなることがわかっている
        // ↑ 違いそう
        configuration.label
            .frame(width: 330, height: 50)
            .contentShape(RoundedRectangle(cornerRadius: 25))
            .padding(15)
            .background(
                contentView(isPressed: configuration.isPressed)
            )
    }
    
    func contentView(isPressed: Bool) -> AnyView {
        if isPressed {
            return AnyView(
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Color.offWhite)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .strokeBorder(Color.gray, lineWidth: 4)
                            .frame(width: 330, height: 50)
                            .blur(radius: 4)
                            .offset(x: 2, y: 2)
                            .mask(RoundedRectangle(cornerRadius: 25)
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]), startPoint: .topLeading, endPoint: .bottomTrailing)))
                                    .frame(width: 330, height: 50)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .strokeBorder(Color.white, lineWidth: 4)
                            .blur(radius: 4)
                            .offset(x: -2, y: -2)
                            .mask(RoundedRectangle(cornerRadius: 25)
                                .fill(LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)))
                                .frame(width: 330, height: 50)
                    )
            )
        } else {
            return AnyView(
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 330, height: 50)
                    .foregroundColor(Color.offWhite)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            )
        }
    }
}

struct ButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            Button(action: {
                
            }){
                Text("Text")
            }.buttonStyle(WideButtonStyle())
        }
    }
}
