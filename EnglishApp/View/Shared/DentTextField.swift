//
//  DentTextField.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/08/18.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import SwiftUI

struct DentTextField: View {
    
    var placeHolder: String
    
    @Binding var text: String
    
    var fieldType: FieldType
    
    var isEditable: Bool
    
    var body: some View {
        contentView()
    }
    
    func contentView() -> AnyView {
        if isEditable {
            switch fieldType {
            case .email:
                return AnyView(
                    TextField(placeHolder, text: $text)
                        .textContentType(.oneTimeCode)
                        .keyboardType(.emailAddress)
                        .padding(.horizontal, 20)
                        .frame(width: 300, height: 50)
                        .background(RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(Color.offWhite)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .strokeBorder(Color.gray, lineWidth: 2)
                                    .frame(width: 300, height: 45)
                                    .blur(radius: 4)
                                    .offset(x: 2, y: 2)
                                    .mask(RoundedRectangle(cornerRadius: 25)
                                            .fill(LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]), startPoint: .topLeading, endPoint: .bottomTrailing)))
                                            .frame(width: 300, height: 50)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .strokeBorder(Color.white, lineWidth: 2)
                                    .blur(radius: 2)
                                    .offset(x: -2, y: -2)
                                    .mask(RoundedRectangle(cornerRadius: 25)
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)))
                                        .frame(width: 300, height: 50)
                            )
                        )
                        .padding(.bottom, 20)
                )
            case .password:
                return AnyView(
                    SecureField(placeHolder, text: $text)
                        .padding(.horizontal, 20)
                        .frame(width: 300, height: 50)
                        .background(RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(Color.offWhite)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .strokeBorder(Color.gray, lineWidth: 2)
                                    .frame(width: 300, height: 45)
                                    .blur(radius: 4)
                                    .offset(x: 2, y: 2)
                                    .mask(RoundedRectangle(cornerRadius: 25)
                                            .fill(LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]), startPoint: .topLeading, endPoint: .bottomTrailing)))
                                            .frame(width: 300, height: 50)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .strokeBorder(Color.white, lineWidth: 2)
                                    .blur(radius: 2)
                                    .offset(x: -2, y: -2)
                                    .mask(RoundedRectangle(cornerRadius: 25)
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)))
                                        .frame(width: 300, height: 50)
                            ))
                        .padding(.bottom, 20)
                )
            default:
                return AnyView(
                    TextField(placeHolder, text: $text)
                        .padding(.horizontal, 20)
                        .frame(width: 300, height: 50)
                        .background(RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(Color.offWhite)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .strokeBorder(Color.gray, lineWidth: 2)
                                    .frame(width: 300, height: 45)
                                    .blur(radius: 4)
                                    .offset(x: 2, y: 2)
                                    .mask(RoundedRectangle(cornerRadius: 25)
                                            .fill(LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]), startPoint: .topLeading, endPoint: .bottomTrailing)))
                                            .frame(width: 300, height: 50)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .strokeBorder(Color.white, lineWidth: 2)
                                    .blur(radius: 2)
                                    .offset(x: -2, y: -2)
                                    .mask(RoundedRectangle(cornerRadius: 25)
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)))
                                        .frame(width: 300, height: 50)
                            ))
                        .padding(.bottom, 20)
                )
            }
        } else {
            return AnyView(
                Text(text)
                    .foregroundColor(.offGray)
                    .padding(.horizontal, 20)
                    .frame(width: 300, height: 50)
                    .background(RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(Color.offWhite)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .strokeBorder(Color.gray, lineWidth: 2)
                                .frame(width: 300, height: 45)
                                .blur(radius: 4)
                                .offset(x: 2, y: 2)
                                .mask(RoundedRectangle(cornerRadius: 25)
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]), startPoint: .topLeading, endPoint: .bottomTrailing)))
                                        .frame(width: 300, height: 50)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .strokeBorder(Color.white, lineWidth: 2)
                                .blur(radius: 2)
                                .offset(x: -2, y: -2)
                                .mask(RoundedRectangle(cornerRadius: 25)
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)))
                                    .frame(width: 300, height: 50)
                        ))
                    .padding(.bottom, 20)
            )
        }
    }
}

struct DentTextField_Previews: PreviewProvider {
    static var previews: some View {
        DentTextField(placeHolder: "", text: Binding.constant(""), fieldType: .other, isEditable: true)
    }
}
