//
//  SettingView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/04.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    
    @State var timePerQuestion: Int = UserDefaults.standard.integer(forKey: "timePerQuestion")
    
    @State var maxQuestionNum: Int = UserDefaults.standard.integer(forKey: "maxQuestionNum")
    
    @State var oneDayQuota: Int = UserDefaults.standard.integer(forKey: "oneDayQuota")
    
    @State var isShowingAlert: Bool = false
    
    @State var isLoading: Bool = false
    
    @State var errorMessage: String = ""
    
    @Binding var isPresented: Bool
    
    var user = User.shared
    
    @State var alertType: AlertType = .restoreAll
    
    enum AlertType {
        case restoreAll
        case backup
        case completion
    }
    
    var body: some View {
        return NavigationView {
            ZStack {
                Color.offWhite
                    .edgesIgnoringSafeArea(.all)
                
                GeometryReader { geometry in
                    VStack {
                        Form {
                            Section(header: Text("ユーザー設定")) {
                                if self.user.email != "" {
                                    HStack {
                                        Text("メールアドレス")
                                        
                                        Spacer()
                                        
                                        Text(self.user.email)
                                            .foregroundColor(Color.offGray)
                                    }
                                } else {
                                    NavigationLink(destination: SetEmailView()) {
                                        HStack {
                                            Text("メールアドレス")
                                            Spacer()
                                            Text("未設定")
                                                .foregroundColor(Color.offGray)
                                        }
                                    }
                                }
                                
                                Picker(selection: self.$timePerQuestion, label: Text("一問あたりの時間")) {
                                    Text("10").tag(10)
                                    Text("15").tag(15)
                                    Text("20").tag(20)
                                    Text("25").tag(25)
                                    Text("30").tag(30)
                                        .navigationBarTitle("一問あたりの時間", displayMode: .inline)
                                }
                                .onReceive([self.timePerQuestion].publisher.first()) { (value) in
                                    self.user.setUserSetting(key: "timePerQuestion", value: self.timePerQuestion)
                                }
                                Picker(selection: self.$maxQuestionNum, label: Text("一回あたりの問題数")) {
                                    Text("5").tag(5)
                                    Text("10").tag(10)
                                    Text("15").tag(15)
                                    Text("20").tag(20)
                                    Text("25").tag(25)
                                    Text("30").tag(30)
                                        .navigationBarTitle("一回あたりの問題数", displayMode: .inline)
                                }
                                .onReceive([self.maxQuestionNum].publisher.first()) { (value) in
                                    self.user.setUserSetting(key: "maxQuestionNum", value: self.maxQuestionNum)
                                }
                                Picker(selection: self.$oneDayQuota, label: Text("一日の目標問題数")) {
                                    Text("10").tag(10)
                                    Text("20").tag(20)
                                    Text("30").tag(30)
                                    Text("50").tag(50)
                                    Text("70").tag(70)
                                    Text("100").tag(100)
                                        .navigationBarTitle("一日の目標問題数", displayMode: .inline)
                                }
                                .onReceive([self.oneDayQuota].publisher.first()) { (value) in
                                    self.user.setUserSetting(key: "oneDayQuota", value: self.oneDayQuota)
                                }
                            }
                            
                            Section(header: Text("このアプリについて")) {
                                HStack {
                                    Text("バージョン")
                                    Spacer()
                                    Text(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String)
                                        .fontWeight(.light)
                                }
                                
                                NavigationLink(destination: SettingTextView(content: TextData.termsOfService)) {
                                    HStack {
                                        Text("利用規約")
                                        Spacer()
                                    }
                                }
                                NavigationLink(destination: SettingTextView(content: TextData.privacyPolicy)) {
                                    HStack {
                                        Text("プライバシーポリシー")
                                        Spacer()
                                    }
                                }
                                NavigationLink(destination: SettingTextView(content: TextData.contact)) {
                                    HStack {
                                        Text("問い合わせ")
                                        Spacer()
                                    }
                                }
                            }
                            
                            Section(header: Text("学習データ")) {
                                NavigationLink(destination: BackupView()) {
                                    HStack {
                                        Text("学習データをバックアップする")
                                        Spacer()
                                    }
                                }
                               
                                NavigationLink(destination: RestoreView()) {
                                    HStack {
                                        Text("学習データを復元する")
                                            .foregroundColor(Color.offRed)
                                        Spacer()
                                    }
                                }
                            }
                            
                             
//                            Section(header: Text("")) {
//                                HStack {
//                                    Spacer()
//                                    Text("学習データを削除する")
//                                        .foregroundColor(Color.offRed)
//                                    Spacer()
//                                }
//                                .contentShape(Rectangle())
//                                .onTapGesture {
//                                    self.isShowingAlert.toggle()
//                                }
//                                .alert(isPresented: self.$isShowingAlert) {
//                                    Alert(title: Text("学習データの削除"),
//                                          message: Text("データは完全に削除されます。\nこの操作は取り消せません。\n※課金情報は残ります。"),
//                                          primaryButton: .cancel(Text("キャンセル")),
//                                          secondaryButton: .destructive(Text("削除"), action: {
//                                            self.isLoading = true
//                                            DispatchQueue.main.async {
//                                                UserSetting.deleteUserData()
//                                                self.isLoading = false
//                                            }
//                                          })
//                                    )
//                                }
//                            }
                        }
                    }
                }
            }
            .navigationBarTitle("設定", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    self.isPresented = false
                }) {
                    Image(systemName: "multiply")
                        .resizable()
                        .frame(width: 15, height: 15)
                }
                .buttonStyle(ShrinkButtonStyle())
                .frame(width: 30, height: 30))
            }
            .onAppear{
                UITableView.appearance().separatorStyle = .singleLine
            }
    }
}

struct SettingView_Previews: PreviewProvider {
    
    static var previews: some View {
        SettingView(isPresented: Binding.constant(true))
    }
}
