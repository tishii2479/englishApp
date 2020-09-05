//
//  TutorialView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/08/16.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct TutorialView: View {
    
    @State var currentPage: Int = 0
    
    var body: some View {
        ZStack {
            Color.offWhite
                .edgesIgnoringSafeArea(.all)
            
            PageView([
                AnyView(TutorialFirstView()),
                AnyView(TutorialSecondView()),
                AnyView(TutorialThirdView()),
                AnyView(TutorialFourthView()),
                AnyView(TutorialFinalView()),
            ], currentPage: $currentPage)
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}
