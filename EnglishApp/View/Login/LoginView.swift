//
//  LoginView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/08/19.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @State var email: String = ""
    
    @State var password: String = ""
    
    @State var isShowingAlert: Bool = false
    
    @State var errorMessage: String = ""
    
    var body: some View {
        ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("Icon")
                    .resizable()
                    .frame(width: 180, height: 180)
                    .padding(.vertical, 40)
                
                DentTextField(placeHolder: "メールアドレス", text: $email, fieldType: .email, isEditable: true)
                    .padding(.bottom, 20)
                
                Button(action: {
                    UIApplication.shared.closeKeyboard()
                    
                    // Authentication
                    self.isShowingAlert = FirebaseManager.authenticate(email: self.email, errorMessage: &self.errorMessage)
                }) {
                    Text("登録してはじめる")
                }
                .alert(isPresented: self.$isShowingAlert) {
                    Alert(title: Text(self.errorMessage))
                }
                .buttonStyle(WideButtonStyle())
                
                Text("メールアドレスは学習データの復元に使われます。")
                    .font(.caption)
                    .padding(.top, 10)
                
                Spacer()
            }
        }
        .gesture(
            TapGesture()
                .onEnded { _ in
                    UIApplication.shared.closeKeyboard()
            }
        )
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(email: "")
    }
}
