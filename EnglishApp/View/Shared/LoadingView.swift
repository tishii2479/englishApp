//
//  LoadingView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/18.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    
    var window: UIWindow
    
    var body: some View {
        ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                Text("ロード中...　アプリを終了せずにお待ちください。")
                    .padding(.bottom, 40)
            }
    
            Image("Icon")
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(window: UIWindow())
    }
}
