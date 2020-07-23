//
//  SettingView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/04.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    
    @Environment(\.presentationMode) var presentation: Binding<PresentationMode>
    
    @State var timePerQuestion: Int = UserDefaults.standard.integer(forKey: "timePerQuestion")
    
    @State var maxQuestionNum: Int = UserDefaults.standard.integer(forKey: "maxQuestionNum")
    
    @State var oneDayQuota: Int = UserDefaults.standard.integer(forKey: "oneDayQuota")
    
    @State var isShowingAlert: Bool = false
    
    @State var isLoading: Bool = false
    
    @Binding var isPresented: Bool
    
    var user = User.shared
    
    var body: some View {
        UITableView.appearance().separatorStyle = .singleLine
        return NavigationView {
            ZStack {
                Color.offWhite
                    .edgesIgnoringSafeArea(.all)
                
                GeometryReader { geometry in

                    VStack {
                        Form {
                            Section(header: Text("ユーザー設定")) {
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
                                    Text("1.0.0")
                                        .fontWeight(.light)
                                }
                                
                                // TODO: これらのタップアクションの処理
                                NavigationLink(destination: SettingTextView(content: TextData.termsOfService)) {
                                    Text("利用規約")
                                }
                                NavigationLink(destination: SettingTextView(content: TextData.privacyPolicy)) {
                                    Text("プライバシーポリシー")
                                }
                                NavigationLink(destination: SettingTextView(content: TextData.contact)) {
                                    Text("問い合わせ")
                                }
                            }
                             
                            Section(header: Text("")) {
                                HStack {
                                    Spacer()
                                    Text("学習データを削除する")
                                        .foregroundColor(Color.offRed)
                                    Spacer()
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    self.isShowingAlert.toggle()
                                }
                                .alert(isPresented: self.$isShowingAlert) {
                                    Alert(title: Text("学習データの削除"),
                                          message: Text("データは完全に削除されます。\nよろしいですか？\n※課金情報は残ります。"),
                                          primaryButton: .cancel(Text("キャンセル")),
                                          secondaryButton: .destructive(Text("削除"), action: {
                                            UserSetting.deleteUserData()
                                    }))
                                }
                            }
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
    }
}

struct SettingView_Previews: PreviewProvider {
    
    static var previews: some View {
        SettingView(isPresented: Binding.constant(true))
    }
}
