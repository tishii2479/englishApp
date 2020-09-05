//
//  BackupView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/08/22.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI
import RealmSwift
import FirebaseStorage
import FirebaseFirestore

struct BackupView: View {
    
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
                Text("学習データのバックアップ")
                    .font(.headline)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 20)
                
                DentTextField(placeHolder: "メールアドレス", text: email != "" ? $email : Binding.constant("未設定"), fieldType: .email, isEditable: false)
                
                Text("端末を引き継ぐ際に、バックアップを取るようにしてください。\nバックアップが取れていない場合、学習データの復旧は行うことができません。")
                    .font(.caption)
                    .fontWeight(.light)
                    .padding(.vertical, 10)
                
                Button(action: {
                    UIApplication.shared.closeKeyboard()
                    
                    self.backup()
                }) {
                    Text("学習データをバックアップする")
                }
                .buttonStyle(WideButtonStyle())
                .alert(isPresented: self.$isShowingAlert) {
                    if self.errorMessage == "" {
                        return Alert(title: Text("学習データをバックアップしました。"))
                    } else {
                        return Alert(title: Text("学習データのバックアップに失敗しました。"), message: Text(self.errorMessage))
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
    
    private func backup() {
           
        let todayDate: String = Date.getTodayDate()

        if todayDate == UserDefaults.standard.string(forKey: "lastBackup") {
            self.errorMessage = "バックアップは一日に一回しかできません。"
            self.isShowingAlert = true
            return
        }
        
        if email == "" {
            self.errorMessage = "メールアドレスが設定されていません。"
            self.isProcessing = false
            self.isShowingAlert = true
            return
        }
        
        if self.isProcessing { return }
        
        ScreenSwitcher.shared.isLoading = true
        self.isProcessing = true

        DispatchQueue.global(qos: .utility).async {
            FirebaseManager.setUserPurchaseData()

            let localFile = Realm.Configuration.defaultConfiguration.fileURL!
            let storageRef = Storage.storage().reference()
            let userDataRef = storageRef.child("userData/" + self.email + "/default.realm")

            let uploadTask = userDataRef.putFile(from: localFile, metadata: nil) { metadata, error in
                if let _error = error {
                    print("upload error : \(_error)")
                    self.errorMessage = "エラー: 30001"
                } else {
                    print("upload success : \(String(describing: metadata))")
                   
                    UserDefaults.standard.set(todayDate, forKey: "lastBackup")
                    self.errorMessage = ""
                }

                DispatchQueue.main.async {
                    ScreenSwitcher.shared.isLoading = false
                    self.isProcessing = false
                    self.isShowingAlert = true
                }
            }

            uploadTask.observe(.progress) { snapshot in
               let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
               / Double(snapshot.progress!.totalUnitCount)
               
               print(percentComplete)
            }
        }
    }
       
}

struct BackupView_Previews: PreviewProvider {
    static var previews: some View {
        BackupView()
    }
}
