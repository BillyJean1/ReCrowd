//
//  ViewController.swift
//  ReCrowd
//
//  Created by Ramon Schriks on 12-12-17.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    private let loginService = LoginService()
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var facebookLoginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Facebook
        facebookLoginButton.delegate = self
    }
    
    // Facebook Login
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        loginService.login(completionBlock: { [weak weakSelf = self] (user,error) in
            if user != nil {
                weakSelf?.performSegue(withIdentifier: "Home", sender: user)
            }
            
            if error != nil {
                weakSelf?.errorMessageLabel.isEnabled = true
                weakSelf?.errorMessageLabel.text = error
            } else {
                weakSelf?.errorMessageLabel.isEnabled = false
            }
        })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Facebook did log out.")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "Home"){
            if let destination = segue.destination as? HomeViewController {
                
                let initialViewController = UIStoryboard(name: "Main", bundle:nil).instantiateInitialViewController() as! UIViewController
                let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
                appDelegate.window?.rootViewController = initialViewController
                
                destination.user = sender as? User!

            }
        }
    }

}
