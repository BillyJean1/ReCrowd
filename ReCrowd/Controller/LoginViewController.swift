//
//  ViewController.swift
//  ReCrowd
//
//  Created by Ramon Schriks on 12-12-17.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import UIKit
import Font_Awesome_Swift
import FBSDKCoreKit
import FBSDKLoginKit
import FirebaseAuth

class LoginViewController: UILoginViewController, FBSDKLoginButtonDelegate {
    
    // SERVICES
    private let loginService = LoginService()
    
    // OUTLETS
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var facebookLoginButton: FBSDKLoginButton!
    
    override func viewDidAppear(_ animated: Bool) {
        if (loginService.isAuth()) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let checkinVC = storyboard.instantiateViewController(withIdentifier: "CheckinViewController") as! CheckInViewController
            self.present(checkinVC, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        facebookLoginButton.delegate = self
        emailLoginButton.setFAText(prefixText: "", icon: .FAEnvelope, postfixText: "Login in with e-mail", size: 18,  forState: .normal)
        emailLoginButton.setFATitleColor(color: .white, forState: .normal)
        
        // Skip login if already authenticated
   
    }

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        loginService.login(completionBlock: { [weak weakSelf = self] (user,error) in
            if user != nil {
                weakSelf?.performSegue(withIdentifier: "Login", sender: user)
            }
            
            if error != nil {
                //weakSelf?.errorMessageLabel.isEnabled = true
                //weakSelf?.errorMessageLabel.text = error
            } else {
               // weakSelf?.errorMessageLabel.isEnabled = false
            }
        })
    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Facebook did log out.")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "Login"){
            if let destination = segue.destination as? CheckInViewController {
                
                if let initialViewController = UIStoryboard(name: "Main", bundle:nil).instantiateInitialViewController(){
                    if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
                        appDelegate.window?.rootViewController = initialViewController
                    }
                }
                destination.user = sender as? User!
            }
        }
    }
}
