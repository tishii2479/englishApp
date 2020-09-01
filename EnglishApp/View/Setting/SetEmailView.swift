//
//  SetEmailView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/09/01.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct SetEmailView: View {
    
    @Environment(\.presentationMode) var presentation: Binding<PresentationMode>
    
    @State var email: String = ""
    
    @State var password: String = ""
    
    @State var isShowingAlert: Bool = false
    
    @State var isProcessing: Bool = false
    
    @State var title: String = ""
    
    @State var message: String = ""
    
    @State var isLogin: Bool = false
    
    var body: some View {
        ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("メールアドレスの設定")
                    .font(.headline)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 20)
                
                DentTextField(placeHolder: "メールアドレス", text: $email, fieldType: .email, isEditable: true)

                DentTextField(placeHolder: "パスワード", text: $password, fieldType: .password, isEditable: true)
                    .padding(.bottom, 20)

                if isLogin {
                    Button(action: {
                        UIApplication.shared.closeKeyboard()
                        
                        // Authentication
                        self.login()
                    }) {
                        Text("ログインする")
                    }
                    .alert(isPresented: self.$isShowingAlert) {
                        Alert(title: Text(self.title), message: Text(self.message))
                    }
                    .buttonStyle(WideButtonStyle())
                    
                } else {
                    Button(action: {
                        UIApplication.shared.closeKeyboard()
                        
                        // Authentication
                        self.authenticate()
                    }) {
                        Text("登録する")
                    }
                    .alert(isPresented: self.$isShowingAlert) {
                        Alert(title: Text(self.title), message: Text(self.message))
                    }
                    .buttonStyle(WideButtonStyle())
                }
                
                Text("メールアドレスは学習データの復元に使われます。")
                    .font(.caption)
                    .padding(.vertical, 10)
                
                Button(action: {
                    self.isLogin.toggle()
                }) {
                    if isLogin {
                        Text("新規登録する方はこちら")
                            .font(.caption)
                    } else {
                        Text("既に登録済みの方はこちら")
                            .font(.caption)
                    }
                }
                
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
    
    private func login() {
        
        if User.shared.email != "" {
            self.title = "エラー"
            self.message = "既に登録しています。"
            self.isShowingAlert = true
            return
        }
        
        if self.isProcessing { return }
        
        self.isProcessing = true
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error)
                self.title = "エラー"
                self.message = "アカウントが見つかりません。"
                self.isShowingAlert = true
            } else {
                // Success
                UserDefaults.standard.set(self.email, forKey: "email")
                User.shared.email = self.email

                self.title = "ログインに成功しました"
                self.message = "アプリを再起動後、設定が反映されます。"
                self.isShowingAlert = true
            }
            
            self.isProcessing = false
        }
        
    }
    
    private func authenticate() {
        
        if User.shared.email != "" {
            self.title = "エラー"
            self.message = "既に登録しています。"
            self.isShowingAlert = true
            return
        }
        
        if self.isProcessing { return }
        
        self.isProcessing = true
        
        let emailRegEx = "[A-Z0-9a-z._+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: email)
        
        if result == false {
            self.title = "エラー"
            self.message = "入力がメールアドレスの形式でありません。"
            self.isShowingAlert = true
            self.isProcessing = false
            return
        }
        
        if password.count < 6 {
            self.title = "エラー"
            self.message = "パスワードは6文字以上にしてください"
            self.isShowingAlert = true
            self.isProcessing = false
            return
        }
        
        Auth.auth().createUser(withEmail: self.email, password: self.password) { authResult, error in
            if let error = error {
                print(error)
                self.title = "エラー"
                self.message = "メールアドレスまたはパスワードが不正です。"
                self.isShowingAlert = true
            } else {
                // Success
                UserDefaults.standard.set(self.email, forKey: "email")
                User.shared.email = self.email
                
                FirebaseManager.setUserPurchaseData()
                
                self.title = "登録に成功しました"
                self.message = "アプリを再起動後、設定が反映されます。"
                self.isShowingAlert = true
            }
            self.isProcessing = false
        }
        
    }
}

struct SetEmailView_Previews: PreviewProvider {
    static var previews: some View {
        SetEmailView()
    }
}
