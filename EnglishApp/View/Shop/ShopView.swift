//
//  ShopView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/08/08.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI
import SwiftyStoreKit

struct ShopView: View {
    
    @ObservedObject var user: User = User.shared
    
    @Binding var isPresented: Bool

    @State var isShowingAlert: Bool = false
    
    @State var isShowingError: Bool = false
    
    @State var selectedItem: ShopItem!
    
    @State var errorText: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.offWhite
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    List {
                        ForEach(ShopData.shopItems, id: \.itemId) { item in
                            Button(action: {
                                self.selectedItem = item
                                self.isShowingError = false
                                self.isShowingAlert = true
                            }) {
                                ShopCellView(item: item)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .alert(isPresented: self.$isShowingAlert) {
                                if self.isShowingError {
                                    return Alert(title: Text("購入に失敗しました"), message: Text("エラー: \(self.errorText)"))
                                } else {
                                    return Alert(title: Text("商品の購入"), message: Text(self.selectedItem.title), primaryButton: .cancel(Text("キャンセル")), secondaryButton: .default(Text("購入"), action: {
                                        SwiftyStoreKit.purchaseProduct(self.selectedItem.itemId, quantity: 1, atomically: true) { result in
                                            switch result {
                                            case .success(let purchase):
                                                print("Purchase Success: \(purchase.productId)")
                                                User.shared.updateUserCoins(difference: self.selectedItem.coin)
                                            case .error(let error):
                                                switch error.code {
                                                case .unknown: self.errorText = "10001"
                                                case .clientInvalid: self.errorText = "10002"
                                                case .paymentCancelled: self.errorText = "購入のキャンセル"
                                                case .paymentInvalid: self.errorText = "10003"
                                                case .paymentNotAllowed: self.errorText = "10004"
                                                case .storeProductNotAvailable: self.errorText = "10005"
                                                case .cloudServicePermissionDenied: self.errorText = "10006"
                                                case .cloudServiceNetworkConnectionFailed: self.errorText = "10007"
                                                case .cloudServiceRevoked: self.errorText = "10008"
                                                default: self.errorText = "20001"
                                                }
                                                self.isShowingAlert = false
                                                self.isShowingError = true
                                                self.isShowingAlert = true
                                            }
                                        }
                                    }))
                                }
                            }
                        }
                        
                        NavigationLink(destination: SettingTextView(content: TextData.actOnSettlement)) {
                            Text("資金決済法に基づく表示")
                        }
                        NavigationLink(destination: SettingTextView(content: TextData.commericalTransaction)) {
                            Text("特定商取引に基づく表示")
                        }
                    }
                }
                .navigationBarTitle("ショップ", displayMode: .inline)
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
                .onAppear{
                    UITableView.appearance().separatorStyle = .singleLine
                }
            }
        }
    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView(isPresented: Binding.constant(true))
    }
}
