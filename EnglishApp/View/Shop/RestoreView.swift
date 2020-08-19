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
    
    enum Option {
        case backup
        case restore
    }
    
    @State var option: Option

    var body: some View {
        contentView()
    }
    
    private func contentView() -> AnyView {
        switch option {
        case .backup:
            return AnyView(
                ZStack {
                    Color.offWhite
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        Text("学習データのバックアップ")
                            .font(.headline)
                            .bold()
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 20)
                        
                        DentTextField(placeHolder: "メールアドレス", text: $email, fieldType: .email, isEditable: false)
                        
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
                }
                .gesture(
                    TapGesture()
                        .onEnded { _ in
                            UIApplication.shared.closeKeyboard()
                    }
                )
            )
        case .restore:
            return AnyView(
                ZStack {
                    Color.offWhite
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        Text("学習データの復元")
                            .font(.headline)
                            .bold()
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 20)
                        
                        DentTextField(placeHolder: "メールアドレス", text: $email, fieldType: .email, isEditable: false)
                            
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
                }
                .gesture(
                    TapGesture()
                        .onEnded { _ in
                            UIApplication.shared.closeKeyboard()
                    }
                )
            )
        }
        
    }
    
    private func backup() {

        if self.isProcessing { return }
        
        self.isProcessing = true
        
        if email == "" {
            self.errorMessage = "メールアドレスが設定されていません。"
            self.isProcessing = false
            self.isShowingAlert = true
            return
        }
    
        FirebaseManager.setUserPurchaseData()
        
        let localFile = Realm.Configuration.defaultConfiguration.fileURL!
        let storageRef = Storage.storage().reference()
        let userDataRef = storageRef.child("userData/" + email + "/default.realm")
        
        let uploadTask = userDataRef.putFile(from: localFile, metadata: nil) { metadata, error in
            if let _error = error {
                print("upload error : \(_error)")
                self.errorMessage = "エラー: 30001"
            } else {
                print("upload success : \(String(describing: metadata))")
                self.errorMessage = ""
            }
            
            self.isProcessing = false
            self.isShowingAlert = true
        }
        
        uploadTask.observe(.progress) { snapshot in
            let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
            / Double(snapshot.progress!.totalUnitCount)
            
            print(percentComplete)
        }
    }
    
    private func restore() {
        
        if self.isProcessing { return }
        
        self.isProcessing = true
        
        if self.email == "" {
            self.errorMessage = "メールアドレスが設定されていません。"
            self.isShowingAlert = true
            return
        }
        
        let localURL = Realm.Configuration.defaultConfiguration.fileURL!
        let storage = Storage.storage()
        let userDataRef = storage.reference(withPath: "userData/" + email + "/default.realm")
        
        userDataRef.downloadURL { url, error in
            if let _error = error {
                print("download error: \(_error)")
                self.errorMessage = "エラー: 30002"

                self.isProcessing = false
                self.isShowingAlert = true
            } else {
                let downloadTask = userDataRef.write(toFile: localURL) { url, error in
                    if let _error = error {
                        print("download error : \(_error)")
                        self.errorMessage = "エラー: 30003"
                    } else {
                        print("download success")
                        UserSetting.reloadData()
                        
                        self.errorMessage = FirebaseManager.getUserPurchaseData()
                    }

                    self.isProcessing = false
                    self.isShowingAlert = true
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

struct RestoreView_Previews: PreviewProvider {
    static var previews: some View {
        RestoreView(option: .backup)
    }
}
