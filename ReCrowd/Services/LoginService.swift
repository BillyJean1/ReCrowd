//
//  LoginService.swift
//  ReCrowd
//
//  Created by Ramon Schriks on 13-12-17.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth

class LoginService {
    private let AUTH_ERROR = "Something went wrong logging in"
    
    public func login(completionBlock: @escaping (User?, String?) -> Void) {
        let req = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name"], tokenString: FBSDKAccessToken.current().tokenString, version: nil, httpMethod: "GET")
        _ = req?.start(completionHandler: { (connection, result, error) -> Void in
            if(error != nil) {
                completionBlock(nil, self.AUTH_ERROR)
            }
            else {
                if let resultObj = result as? NSObject {
                    self.authFacebook()
                    completionBlock(User(id: resultObj.value(forKey: "id") as! String? ?? nil,
                                         name: resultObj.value(forKey: "name") as! String? ?? nil,
                                         email: resultObj.value(forKey: "email") as! String? ?? nil), nil
                    )
                }
            }
        })
    }
    
    private func authFacebook() {
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        Auth.auth().signIn(with: credential) { (user, error) in
            if(error != nil){
                // TODO: Log errors
            }
        }
    }
}
