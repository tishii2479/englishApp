//
//  TutorialViewPages.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/08/16.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct TutorialFirstView: View {
    
    @Binding var isShowingTutorial: Bool
    
    var body: some View {
        ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
        
            VStack {
                Spacer()
                Image("Tutorial_1")
                    .resizable()
                    .scaledToFit()
                    .frame(height: UIScreen.main.bounds.height * 0.8)
                    .shadow(radius: 15)
            }
            .padding(.horizontal, 30)
        }
    }
    
}

struct TutorialSecondView: View {
    
    @Binding var isShowingTutorial: Bool
    
    var body: some View {
        ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                Image("Tutorial_2")
                    .resizable()
                    .scaledToFit()
                    .frame(height: UIScreen.main.bounds.height * 0.8)
                    .shadow(radius: 15)

            }
            .padding(.horizontal, 30)
        }
    }
    
}

struct TutorialThirdView: View {
    
    @Binding var isShowingTutorial: Bool
    
    var body: some View {
        ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                Image("Tutorial_3")
                    .resizable()
                    .scaledToFit()
                    .frame(height: UIScreen.main.bounds.height * 0.8)
                    .shadow(radius: 15)

            }
            .padding(.horizontal, 30)
        }
    }
    
}

struct TutorialFourthView: View {
    
    @Binding var isShowingTutorial: Bool
    
    var body: some View {
        ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                Image("Tutorial_4")
                    .resizable()
                    .scaledToFit()
                    .frame(height: UIScreen.main.bounds.height * 0.8)
                    .shadow(radius: 15)

            }
            .padding(.horizontal, 30)
        }
    }
    
}

