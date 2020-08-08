//
//  ShopView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/08/08.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct ShopView: View {
    
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
                                Alert(title: Text("商品の購入"), message: Text(self.selectedItem.title), primaryButton: .cancel(Text("キャンセル")), secondaryButton: .default(Text("購入")))
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
