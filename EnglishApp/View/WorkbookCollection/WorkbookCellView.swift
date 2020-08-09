//
//  WorkbookCellView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/04.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct WorkbookCellView: View {
    
    var workbook: Workbook
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.offWhite)
                    .frame(width: geometry.size.width - 20, height: 150)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
                    .shadow(color: Color.white.opacity(0.7), radius: 5, x: -3, y: -3)
                
                // Details
                HStack {
                    VStack(alignment: .leading) {
                        Text(self.workbook.title)
                            .font(.footnote)
                            .bold()
                            .padding(.bottom, 10)
                        Text(self.workbook.detail)
                            .font(.caption)
                            .fontWeight(.ultraLight)
                        
                        Spacer()
                        
                        Text(WorkbookFormatter.formatDifficult(difficulty: self.workbook.difficulty))
                            .font(.caption)
                        
                        HStack {
                            Text(WorkbookFormatter.formatQuestionNumber(number: self.workbook.questionNumber))
                                .font(.caption)
                            Spacer()
                            Text(WorkbookFormatter.formatPrice(price: self.workbook.price))
                                .font(.caption)
                        }
                    }
                    .padding(15)
                    
                    Spacer()
                }
                .frame(width: geometry.size.width - 10, height: 160)
                
                // Lock Layer
                Group {
                    if self.workbook.isPlayable == false {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color.offBlack.opacity(0.3))
                                .frame(width: geometry.size.width - 20, height: 150)
                            
                            Image(systemName: "lock")
                                .resizable()
                                .scaledToFill()
                                .foregroundColor(Color.offWhite)
                                .frame(width: 30, height: 30)
                        }
                    }
                }
            }
        }.frame(minHeight: 170)
        
    }
    
}

struct WorkbookCellView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)

            HStack {
                WorkbookCellView(workbook: Workbook())
                WorkbookCellView(workbook: Workbook())
            }
        }
    }
}
