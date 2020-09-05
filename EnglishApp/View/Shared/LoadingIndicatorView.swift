//
//  LoadingIndicatorView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/08/08.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct LoadingIndicatorView: View {
    
    @State var isIndicating: Bool = false
    
    @ObservedObject var screenSwitcher: ScreenSwitcher = ScreenSwitcher.shared
    
    var body: some View {
        ZStack {
            Color.offBlack.opacity(0.2)
                .edgesIgnoringSafeArea(.all)
            
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.offBlack.opacity(0.8))
                .frame(width: 100, height: 100)
            
            IndicatorView(isIndicating: self.$isIndicating, style: .large)
            
            if screenSwitcher.loadingText != "" {
                VStack {
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.offBlack.opacity(0.8))
                            .frame(width: 200, height: 40)
                        
                        Text(screenSwitcher.loadingText)
                            .font(.caption)
                            .fontWeight(.light)
                            .foregroundColor(Color.offWhite)
                    }
                    .padding(.bottom, 160)
                }
            }
        }
        .onAppear {
            print("indicator appear")
            self.isIndicating = true
        }
        .onDisappear {
            print("indicator disappear")
            self.isIndicating = false
        }
    }
}

struct LoadingIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicatorView()
    }
}
