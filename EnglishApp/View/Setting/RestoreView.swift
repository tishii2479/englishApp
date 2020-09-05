//
//  RestoreView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/08/18.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI
import RealmSwift
import FirebaseStorage
import FirebaseFirestore

struct RestoreView: View {

    @State var email: String = User.shared.email
    
    @State var isShowingAlert: Bool = false
    
    @State var errorMessage: String = ""
    
    @State var isProcessing: Bool = false
    
    @ObservedObject var screenSwitcher: ScreenSwitcher = ScreenSwitcher.shared
    
    var body: some View {
        ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("学習データの復元")
                    .font(.headline)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 20)
                
                DentTextField(placeHolder: "メールアドレス", text: email != "" ? $email : Binding.constant("未設定"), fieldType: .email, isEditable: false)

                Text("注意!\nバックアップデータが古い場合には、学習データが失われる可能性があります。\nデータの復元を行う際には、必ず直前にバックアップを取った状態で行ってください。")
                    .font(.caption)
                    .fontWeight(.light)
                    .foregroundColor(Color.red)
                    .padding(.vertical, 10)
                
                Button(action: {
                    UIApplication.shared.closeKeyboard()
                    
                    self.restore()
                }) {
                    Text("学習データを復元する")
                }
                .buttonStyle(WideButtonStyle())
                .alert(isPresented: self.$isShowingAlert) {
                    if self.errorMessage == "" {
                        return Alert(title: Text("学習データの復元に成功しました。"), message: Text("アプリを一度再起動するとデータが反映されます。"))
                    } else {
                        return Alert(title: Text("学習データの復元に失敗しました。"), message: Text(self.errorMessage))
                    }
                }
                
                Text("不具合が生じた方はeidoku1234@gmail.comにお問い合わせください。")
                    .font(.caption)
                    .fontWeight(.light)
                    .padding(.top, 20)
                
                Spacer()
            }
            .padding(.horizontal, 30)
            
            if screenSwitcher.isLoading {
                LoadingIndicatorView()
            }
        }
        .gesture(
            TapGesture()
                .onEnded { _ in
                    UIApplication.shared.closeKeyboard()
            }
        )
    }
    
   
    private func restore() {
        
        let todayDate: String = Date.getTodayDate()
        
        if todayDate == UserDefaults.standard.string(forKey: "lastRestore") {
            self.errorMessage = "復元は一日に一回しかできません。"
            self.isShowingAlert = true
            return
        }
        
        if self.email == "" {
            self.errorMessage = "メールアドレスが設定されていません。"
            self.isShowingAlert = true
            return
        }
        
        if self.isProcessing { return }

        ScreenSwitcher.shared.isLoading = true
        self.isProcessing = true
        
        let localURL = Realm.Configuration.defaultConfiguration.fileURL!
        let storage = Storage.storage()
        let userDataRef = storage.reference(withPath: "userData/" + email + "/default.realm")
        
        DispatchQueue.global(qos: .utility).async {
            userDataRef.downloadURL { url, error in
                if let _error = error {
                    print("download error: \(_error)")
                    self.errorMessage = "バックアップデータが存在しません。"
                    ScreenSwitcher.shared.isLoading = false
                    
                    self.isProcessing = false
                    self.isShowingAlert = true
                } else {
                    let downloadTask = userDataRef.write(toFile: localURL) { url, error in
                        if let _error = error {
                            print("download error : \(_error)")
                            self.errorMessage = "エラー: 30003"
                        } else {
                            print("download success")
                            
                            UserDefaults.standard.set(todayDate, forKey: "lastRestore")
                            UserDefaults.standard.set(true, forKey: "needReload")
                            
                            self.errorMessage = FirebaseManager.getUserPurchaseData()
                        }

                        DispatchQueue.main.async {
                            ScreenSwitcher.shared.isLoading = false
                            self.isProcessing = false
                            self.isShowingAlert = true
                        }
                    }
                    
                    downloadTask.observe(.progress) { snapshot in
                        let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
                        / Double(snapshot.progress!.totalUnitCount)
                        
                        print(percentComplete)
                    }
                }
            }
        }
    }
}

struct RestoreView_Previews: PreviewProvider {
    static var previews: some View {
        RestoreView()
    }
}
