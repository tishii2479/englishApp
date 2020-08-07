//
//  CustomTabBar.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/08/07.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct CustomTabBar: View {
    
    @Binding var selectedIndex: Int
    
    var body: some View {
        ZStack {
            // Background
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.offWhite)
                .frame(height: 60)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            
            HStack {
                Spacer()
                
                Button(action: {
                    self.selectedIndex = 0
                }) {
                    ZStack {
                        Group {
                            if self.selectedIndex == 0 {
                                RoundedRectangle(cornerRadius: 15)
                                    .frame(width: 110, height: 45)
                                    .foregroundColor(Color.offWhite)
                                    .contentShape(RoundedRectangle(cornerRadius: 15).inset(by: 15))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .strokeBorder(Color.gray, lineWidth: 4)
                                            .frame(width: 110, height: 45)
                                            .blur(radius: 4)
                                            .offset(x: 2, y: 2)
                                            .mask(RoundedRectangle(cornerRadius: 15)
                                                    .fill(LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]), startPoint: .topLeading, endPoint: .bottomTrailing)))
                                                    .frame(width: 110, height: 45)
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .strokeBorder(Color.white, lineWidth: 4)
                                            .blur(radius: 4)
                                            .offset(x: -2, y: -2)
                                            .mask(RoundedRectangle(cornerRadius: 15)
                                                .fill(LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)))
                                                .frame(width: 110, height: 45)
                                    )
                            } else {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.offWhite)
                                    .frame(width: 110, height: 45)
                                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                            }
                        }
                        
                        Image(systemName: "house")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(20)
                            .frame(width: 70, height: 70)
                    }
                }
                .buttonStyle(ShrinkButtonStyle())
                
                Spacer()
                
                Button(action: {
                    self.selectedIndex = 1
                }) {
                    ZStack {
                        Group {
                            if self.selectedIndex == 1 {
                                RoundedRectangle(cornerRadius: 15)
                                    .frame(width: 110, height: 45)
                                    .foregroundColor(Color.offWhite)
                                    .contentShape(RoundedRectangle(cornerRadius: 15).inset(by: 15))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .strokeBorder(Color.gray, lineWidth: 4)
                                            .frame(width: 110, height: 45)
                                            .blur(radius: 4)
                                            .offset(x: 2, y: 2)
                                            .mask(RoundedRectangle(cornerRadius: 15)
                                                    .fill(LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]), startPoint: .topLeading, endPoint: .bottomTrailing)))
                                                    .frame(width: 110, height: 45)
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .strokeBorder(Color.white, lineWidth: 4)
                                            .blur(radius: 4)
                                            .offset(x: -2, y: -2)
                                            .mask(RoundedRectangle(cornerRadius: 15)
                                                .fill(LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)))
                                                .frame(width: 110, height: 45)
                                    )
                            } else {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.offWhite)
                                    .frame(width: 110, height: 45)
                                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                                    .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                            }
                        }
                                
                        Image(systemName: "book")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(20)
                            .frame(width: 70, height: 70)
                    }
                }
                .buttonStyle(ShrinkButtonStyle())
                
                Spacer()
            }
        }
        .padding(20)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            
            CustomTabBar(selectedIndex: Binding.constant(0))
        }
    }
}
