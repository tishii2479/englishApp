//
//  WorkbookCellView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/04.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct WorkbookCellView: View {
    
    var workbookModel: Workbook
    
    var body: some View {
        ZStack {
            // Background
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.offWhite)
                .frame(height: 150)
                .padding(.horizontal, 10)
                .padding(.vertical, 20)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
                .shadow(color: Color.white.opacity(0.7), radius: 5, x: -3, y: -3)
            
            // Details
            HStack {
                VStack(alignment: .leading) {
                    Text(workbookModel.title)
                        .bold()
                    Text(workbookModel.detail)
                        .fontWeight(.ultraLight)
                    
                    Spacer()
                    Text(WorkbookFormatter.formatDifficult(difficulty: workbookModel.difficulty))
                        .font(.footnote)
                    
                    HStack {
                        Text(WorkbookFormatter.formatQuestionNumber(number: workbookModel.questionNumber))
                            .font(.footnote)
                        Spacer()
                        Text(WorkbookFormatter.formatPrice(price: workbookModel.price))
                            .font(.footnote)
                    }
                }
                .padding(15)
                .padding(.leading, 10)
                Spacer()
            }
            .frame(height: 150)
        }
    }
    
}

struct WorkbookCellView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            
            HStack {
                WorkbookCellView(workbookModel: Workbook())
                WorkbookCellView(workbookModel: Workbook())
            }
        }
    }
}
