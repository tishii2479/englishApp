//
//  CustomNavigationBar.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/11.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct CustomNavigationBar: View {
    
    @Environment(\.presentationMode) var presentation: Binding<PresentationMode>
    
    var hasReturn: Bool
    
    var hasSetting: Bool
    
    var title: String
    
    var body: some View {
        ZStack {
            Color.clear
                .edgesIgnoringSafeArea(.all)
            
            Text(title)
            
            HStack {
                Group {
                    if hasReturn {
                        ReturnButtonView(presentation: presentation)
                    }
                }
                
                Spacer()
                
                Group {
                    if hasSetting {
                        SettingButtonView()
                    }
                }
            }
            .padding(.horizontal, 10)
        }
        .padding(.top, 15)
        .frame(height: 20)
    }
}

struct CustomNavigationBar_Previews: PreviewProvider {
    
    static var previews: some View {
        CustomNavigationBar(hasReturn: true, hasSetting: true, title: "Title")
    }
}
