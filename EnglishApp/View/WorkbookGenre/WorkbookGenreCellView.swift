//
//  WorkbookGenreCellView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/08/07.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct WorkbookGenreCellView: View {
    
    var category: Category
    
    var body: some View {
        ZStack {
            // Background
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.offWhite)
                .frame(height: 140)
                .padding(20)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
                .shadow(color: Color.white.opacity(0.7), radius: 5, x: -3, y: -3)
            
            VStack {

                // Title
                HStack {
                    Text(category.title)
                        .font(.body)
                        .bold()
                    
                    Spacer()
                }

                // Detail
                HStack {
                    Text(category.detail)
                        .font(.subheadline)
                        .fontWeight(.light)
                    Spacer()
                }.padding(.top, 5)
    
                Spacer()
                
                // Progress Text
                HStack {
                    Spacer()
                    
                    Text(String(format: "%.2f", Double(100 * self.category.correctQuestionNum) / Double(self.category.totalQuestionNum)) + "%")
                        .font(.footnote)
                        .fontWeight(.light)
                        .padding(.trailing, 10)
                }
                
                // Progress Bar
                GeometryReader{ geometry in
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: geometry.size.width, height: 20)
                            .foregroundColor(Color.offWhite)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(Color.gray, lineWidth: 2)
                                    .frame(width: geometry.size.width, height: 20)
                                    .blur(radius: 2)
                                    .offset(x: 1, y: 4)
                                    .mask(RoundedRectangle(cornerRadius: 25)
                                            .fill(LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]), startPoint: .topLeading, endPoint: .bottomTrailing)))
                                    .frame(width: geometry.size.width, height: 20)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(Color.white, lineWidth: 3)
                                    .blur(radius: 2)
                                    .offset(x: 0, y: -4)
                                    .mask(RoundedRectangle(cornerRadius: 10)
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)))
                                        .frame(width: geometry.size.width, height: 20)
                            )
                        HStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: (geometry.size.width) * CGFloat(self.category.correctQuestionNum) / CGFloat(self.category.totalQuestionNum), height: 15)
                                .foregroundColor(Color.offRed)
                                .shadow(color: Color.offRed, radius: 6, x: 7, y: 7)
                                .shadow(color: Color.white.opacity(0.5), radius: 6, x: -5, y: -5)
                            Spacer()
                        }
                    }
                }.frame(maxHeight: 20)
            }
            .padding(40)
            .frame(height: 180)
        }
    }
}

struct WorkbookGenreCellView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            VStack {
                WorkbookGenreCellView(category: Category())
                WorkbookGenreCellView(category: Category())
                WorkbookGenreCellView(category: Category())
            }
        }
    }
}
