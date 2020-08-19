//
//  TutorialViewPages.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/08/16.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI
import AuthenticationServices

struct TutorialFirstView: View {

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

struct TutorialFinalView: View {
    
    var appleSignInManager = AppleSignInManager()
    
    var body: some View {
        ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Button(action: {
                    self.showAppleLogin()
                }) {
                    SignInButton()
                        .frame(width: 240, height: 50)
                        .padding(.bottom, 30)
                }
            }
            .padding(.horizontal, 30)
        }
    }
    
    private func showAppleLogin() {
        let request = ASAuthorizationAppleIDProvider().createRequest()

        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = appleSignInManager
        controller.performRequests()
    }
}
