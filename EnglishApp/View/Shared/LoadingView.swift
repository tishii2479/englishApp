//
//  LoadingView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/07/18.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    
    var body: some View {
        ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Text("ロード中...　アプリを終了せずにお待ちください。")
                    .font(.footnote)
                    .padding(.bottom, 10)
                Text("※初回ダウンロードは30秒程度時間がかかります。")
                    .font(.caption)
                    .padding(.bottom, 80)
            }
    
            Image("Icon")
                .resizable()
                .frame(width: 220, height: 220)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
