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
    public static let shared = LoginService()
    
    private let AUTH_ERROR = "Something went wrong logging in"
    public static let USER_KEY = "logged_in_user"
    
    public func isAuth() -> Bool {
        let user = Auth.auth().currentUser
        return user != nil
    }
    
    public func login(completionBlock: @escaping (User?, String?) -> Void) {
        if let current = FBSDKAccessToken.current(), let token = current.tokenString {
           let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name"], tokenString: token, version: nil, httpMethod: "GET")
            _ = request?.start(completionHandler: { (connection, result, error) -> Void in
                if(error != nil) {
                    completionBlock(nil, self.AUTH_ERROR)
                }
                else {
                    if let resultObj = result as? NSObject {
                        self.authFacebook()
                        let loggedInUser = User(id: resultObj.value(forKey: "id") as! String? ?? nil,
                                                name: resultObj.value(forKey: "name") as! String? ?? nil,
                                                email: resultObj.value(forKey: "email") as! String? ?? nil)
                        
                        self.saveLoggedInUser(user: loggedInUser)
                        completionBlock(loggedInUser, nil)
                    }
                }
            })
        }
    }
    
    public func saveLoggedInUser(user: User) {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: LoginService.USER_KEY)
        
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: user)
        userDefaults.setValue(encodedData, forKey: LoginService.USER_KEY)
        userDefaults.synchronize()
    }
    
    public func getLoggedInUser() -> User? {
        let userDefaults = UserDefaults.standard
        let data = userDefaults.object(forKey: LoginService.USER_KEY)
        if let decodedData = data as? Data {
            if let decodedUser = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as? User {
                return decodedUser
            }
        }
        return nil
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
