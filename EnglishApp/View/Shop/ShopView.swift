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
    
    @State var selectedItem: ShopItem!
    
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
                                self.isShowingAlert = true
                            }) {
                                ShopCellView(item: item)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .alert(isPresented: self.$isShowingAlert) {
                                Alert(title: Text("商品の購入"), message: Text(self.selectedItem.title), primaryButton: .cancel(Text("キャンセル")), secondaryButton: .default(Text("購入"), action: {
                                    SwiftyStoreKit.purchaseProduct(item.itemId, quantity: 1, atomically: true) { result in
                                        print(self.selectedItem.itemId)
                                        switch result {
                                        case .success(let purchase):
                                            print("Purchase Success: \(purchase.productId)")
                                            
                                        case .error(let error):
                                            switch error.code {
                                            case .unknown: print("Unknown error. Please contact support")
                                            case .clientInvalid: print("Not allowed to make the payment")
                                            case .paymentCancelled: break
                                            case .paymentInvalid: print("The purchase identifier was invalid")
                                            case .paymentNotAllowed: print("The device is not allowed to make the payment")
                                            case .storeProductNotAvailable: print("The product is not available in the current storefront")
                                            case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
                                            case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
                                            case .cloudServiceRevoked: print("User has revoked permission to use this cloud service")
                                            default: print("Unknown error")
                                            }
                                        }
                                    }
                                }))
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
