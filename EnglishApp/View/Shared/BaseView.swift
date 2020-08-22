//
//  BaseView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/08/07.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct BaseView: View {
    
    @State var isShowingTabBar: Bool = true
    
    @State var selectedIndex: Int = 0
    
    @ObservedObject var user: User = User.shared
    
    @ObservedObject var screenSwitcher: ScreenSwitcher = ScreenSwitcher.shared
    
    var body: some View {
        ZStack {
            if screenSwitcher.showLogin {
                LoginView()
            } else {
                ZStack {
                    if selectedIndex == 0 {
                        HomeView(homeViewModel: HomeViewModel(), isShowingTabBar: $isShowingTabBar)
                    } else if selectedIndex == 1 {
                        NavigationView {
                            WorkbookGenreCollectionView(isShowingTabBar: $isShowingTabBar)
                        }
                    }
                }
                
                VStack {
                    Spacer()
                    
                    if isShowingTabBar {
                        CustomTabBar(selectedIndex: $selectedIndex)
                    }
                }
                .padding(.top, 40)

                if screenSwitcher.isLoading {
                    LoadingIndicatorView()
                }
            }
        }
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
