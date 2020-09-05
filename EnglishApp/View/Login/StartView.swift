//
//  StartView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/09/01.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct StartView: View {
    
    @State var showAlert: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.offWhite
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image("Icon")
                        .resizable()
                        .frame(width: 180, height: 180)
                        .padding(.vertical, 40)
                                        
                    NavigationLink(destination: LoginView()) {
                        Text("メールアドレスを登録する")
                    }
                    .buttonStyle(WideButtonStyle())
                    
                    Button(action: {
                        self.showAlert.toggle()
                    }) {
                        Text("メールアドレスを登録せずに始める")
                            .font(.footnote)
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 40)
                    .alert(isPresented: self.$showAlert) {
                        Alert(title: Text("メールアドレスの登録"), message: Text("メールアドレスの登録を行わずに始めます。メールアドレスの登録は後ほど行うことができます。"), primaryButton: .default(Text("始める"), action: {
                            self.start()
                        }), secondaryButton: .cancel(Text("キャンセル")))
                    }
                    
                    Text("メールアドレスは学習データのバックアップに使われます。\nメールアドレスの登録は後ほど行うことができます。")
                        .font(.caption)
                        .fontWeight(.light)
                        .lineLimit(nil)
                        .padding(.vertical, 10)
                }
            }
        }
    }
    
    private func start() {
        print("start")
        UserDefaults.standard.set(true, forKey: "userStarted")
        ScreenSwitcher.shared.showLogin = false
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
