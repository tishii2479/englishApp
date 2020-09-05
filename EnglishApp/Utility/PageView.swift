//
//  PageView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/08/16.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct PageView<Page: View>: View {
    
    var viewControllers: [UIHostingController<Page>]
    @Binding var currentPage: Int

    init(_ views: [Page], currentPage: Binding<Int>) {
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
        self._currentPage = currentPage
    }

    var body: some View {
        ZStack {
            VStack {
                PageViewController(controllers: viewControllers, currentPage: $currentPage)
            }
            
            HStack {
//                if self.currentPage != 0 {
//                    Button(action: {
//                        self.currentPage -= 1
//                    }) {
//                        Image(systemName: "chevron.compact.left")
//                            .resizable()
//                            .foregroundColor(Color.offGray)
//                            .frame(width: 10, height: 50)
//                    }
//                }
                
                Spacer()
                
                if self.currentPage != viewControllers.count - 1 {
                    Button(action: {
                        self.currentPage += 1
                    }) {
                        Image(systemName: "chevron.compact.right")
                            .resizable()
                            .foregroundColor(Color.offGray)
                            .frame(width: 10, height: 50)
                    }
                }
            }
            .padding(.horizontal, 15)
            
//            VStack {
//                Spacer()
//
//                ZStack {
//                    RoundedRectangle(cornerRadius: 15)
//                        .frame(width: 120, height: 30)
//                        .foregroundColor(Color.lightGray.opacity(0.8))
//                    HStack {
//                        ForEach(0 ..< 4) { i in
//                            Circle()
//                                .fill(i == self.currentPage ? Color.offRed : Color.offWhite)
//                                .frame(width: 10, height: 10)
//                        }
//                    }
//                }
//                .padding(.bottom, 30)
//            }
        }
    }
}
