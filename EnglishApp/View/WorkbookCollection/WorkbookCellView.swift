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
        ZStack {
            // Background
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.offWhite)
                .frame(width: 180, height: 150)
                .padding(.horizontal, 10)
                .padding(.vertical, 20)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
                .shadow(color: Color.white.opacity(0.7), radius: 5, x: -3, y: -3)
            
            // Details
            HStack {
                VStack(alignment: .leading) {
                    Text(workbook.title)
                        .font(.footnote)
                        .bold()
                        .padding(.bottom, 10)
                    Text(workbook.detail)
                        .font(.caption)
                        .fontWeight(.ultraLight)
                    
                    Spacer()
                    Text(WorkbookFormatter.formatDifficult(difficulty: workbook.difficulty))
                        .font(.caption)
                    
                    HStack {
                        Text(WorkbookFormatter.formatQuestionNumber(number: workbook.questionNumber))
                            .font(.caption)
                        Spacer()
                        Text(WorkbookFormatter.formatPrice(price: workbook.price))
                            .font(.caption)
                    }
                }
                .padding(15)
                .padding(.leading, 10)
                Spacer()
            }
            .frame(width: 200, height: 160)
        }
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
