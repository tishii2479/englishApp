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
        let isPressed = configuration.isPressed
        
        return ZStack {
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color.offWhite)
                .contentShape(RoundedRectangle(cornerRadius: 25).inset(by: 15))
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            
            configuration.label
                .contentShape(RoundedRectangle(cornerRadius: 25).inset(by: 15))
        }
        .frame(maxWidth: 330, maxHeight: 50)
        .padding(10)
        .scaleEffect(x: isPressed ? 0.9 : 1, y: isPressed ? 0.9 : 1, anchor: .center)
        .animation(.spring(response: 0.2, dampingFraction: 0.9, blendDuration: 0))
    }
}

struct WorkbookCellStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {

        let isPressed = configuration.isPressed

        return configuration.label
            .scaleEffect(x: isPressed ? 0.9 : 1, y: isPressed ? 0.9 : 1, anchor: .center)
            .animation(.spring(response: 0.2, dampingFraction: 0.9, blendDuration: 0))
    }
}

struct DentButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        // insetを指定することで修正
        // ただ、アニメーションがあまり美しくないため使っていない
        ZStack {
            contentView(isPressed: configuration.isPressed)
            
            configuration.label
                .frame(width: 330, height: 50)
                .contentShape(RoundedRectangle(cornerRadius: 25).inset(by: 15))
        }
        .frame(maxWidth: 330, maxHeight: 50)
        .padding(10)
    }
    
    func contentView(isPressed: Bool) -> AnyView {
        if isPressed {
            return AnyView(
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Color.offWhite)
                    .contentShape(RoundedRectangle(cornerRadius: 25).inset(by: 15))
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
                    .foregroundColor(Color.offWhite)
                    .contentShape(RoundedRectangle(cornerRadius: 25).inset(by: 15))
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
