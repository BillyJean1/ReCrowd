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
    @IBOutlet weak var recrowdLogo: UIImageView!
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var facebookLoginButton: FBSDKLoginButton!
    
    override func viewDidAppear(_ animated: Bool) {
        if (loginService.isAuth()) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let checkinVC = storyboard.instantiateViewController(withIdentifier: "CheckInViewController") as! CheckInViewController
            self.present(checkinVC, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        facebookLoginButton.delegate = self
        emailLoginButton.setImage(UIImage.init(icon: .FAEnvelope, size: CGSize(width: 22, height: 25), textColor: .white), for: .normal)
        emailLoginButton.imageEdgeInsets = UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)
        emailLoginButton.titleEdgeInsets = UIEdgeInsetsMake(0.0, 106.0, 0.0, 0.0)
        emailLoginButton.contentHorizontalAlignment = .left
        self.view.layer.insertSublayer(getGradientBackground(), at: 0)
        self.view.bringSubview(toFront: recrowdLogo)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
          self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
    }

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        loginService.login(completionBlock: { [weak weakSelf = self] (user,error) in
            if user != nil {
                let userDefaults = UserDefaults.standard
                    if userDefaults.bool(forKey: "onboardingComplete"){
                         weakSelf?.performSegue(withIdentifier: "Incheck", sender: user)

                    } else{
                       weakSelf?.performSegue(withIdentifier: "Onboard", sender: self)
                }

            }
            
            if error != nil {
                print("Error while segueing from Login to Checkin.")
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
}

