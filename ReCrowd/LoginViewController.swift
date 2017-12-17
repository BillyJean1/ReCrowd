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

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    // SERVICES
    private let loginService = LoginService()
    
    // OUTLETS
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var facebookLoginButton: FBSDKLoginButton!
    @IBOutlet weak var recrowdLogoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // FACEBOOK CONFIG
        facebookLoginButton.delegate = self

        // UI CONFIG
        setGradientBackground()
        self.view.bringSubview(toFront: recrowdLogoImageView)
    
        emailLoginButton.setFAText(prefixText: "", icon: .FAEnvelope, postfixText: "Login in with e-mail", size: 18,  forState: .normal)
        emailLoginButton.setFATitleColor(color: .white, forState: .normal)
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        loginService.login(completionBlock: { [weak weakSelf = self] (user,error) in
            if user != nil {
                weakSelf?.performSegue(withIdentifier: "Home", sender: user)
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
        if(segue.identifier == "Home"){
            if let destination = segue.destination as? HomeViewController {
                
                if let initialViewController = UIStoryboard(name: "Main", bundle:nil).instantiateInitialViewController(){
                    if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
                        appDelegate.window?.rootViewController = initialViewController
                    }
                }
                destination.user = sender as? User!
            }
        }
    }

    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 151.0/255.0, green: 215.0/255.0, blue: 243.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 18.0/255.0, green: 107.0/255.0, blue: 189.0/255.0, alpha: 1.0).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ colorTop, colorBottom]
        gradientLayer.locations = [ 0.0, 1.0]
        gradientLayer.frame = CGRect(x:0, y: 0, width: self.view.frame.width, height:self.view.frame.height/1.4)
        
        self.view.layer.addSublayer(gradientLayer)
    }
}
