//
//  AppleSignInManager.swift
//  EnglishApp
//
//  Created by Tatsuya Ishii on 2020/08/18.
//  Copyright © 2020 Tatsuya Ishii. All rights reserved.
//

import Foundation
import AuthenticationServices

class AppleSignInManager: NSObject {
    override init() {}
}

extension AppleSignInManager: ASAuthorizationControllerDelegate {
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let email = appleIDCredential.email

            guard let _email = email else {
                print("second device")
                return
            }

            UserDefaults.standard.set(_email, forKey: "email")
            User.shared.email = _email
//            User.shared.showLogin = false
        }
    }

    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
        print("error")
    }
}
