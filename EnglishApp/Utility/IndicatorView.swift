//
//  IndicatorView.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/08/22.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct IndicatorView: UIViewRepresentable {
    
    @Binding var isIndicating: Bool
    
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: style)
        view.color = .white
        return view
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        self.isIndicating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct IndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorView(isIndicating: Binding.constant(true), style: .medium)
    }
}
