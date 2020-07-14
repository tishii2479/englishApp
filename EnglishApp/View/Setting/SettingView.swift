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
    
    @State var showCorrectness: Bool = UserDefaults.standard.bool(forKey: "showCorrectness")
    
    @Binding var isPresented: Bool
    
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
                                    UserDefaults.standard.set(self.timePerQuestion, forKey: "timePerQuestion")
                                    User.shared.timePerQuestion = self.timePerQuestion
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
                                    UserDefaults.standard.set(self.maxQuestionNum, forKey: "maxQuestionNum")
                                    User.shared.maxQuestionNum = self.maxQuestionNum
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
                                    UserDefaults.standard.set(self.oneDayQuota, forKey: "oneDayQuota")
                                    User.shared.onedayQuota = self.oneDayQuota
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
                                Text("利用規約")
                                    .onTapGesture {
                                        print("tapped")
                                    }
                                
                                Text("プライバシーポリシー")
                                    .onTapGesture {
                                        print("tapped")
                                    }
                                
                                Text("問い合わせ")
                                    .onTapGesture {
                                        print("tapped")
                                    }
                            }
                             
                            Section(header: Text("")) {
                                HStack {
                                    Spacer()
                                    Text("学習データを削除する")
                                        .foregroundColor(Color.offRed)
                                    Spacer()
                                }
                                .onTapGesture {
                                    print("tapped")
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
