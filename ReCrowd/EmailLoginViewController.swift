//
//  EmailLoginViewController.swift
//  ReCrowd
//
//  Created by mac on 17-12-17.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import UIKit
import Firebase

class EmailLoginViewController: UILoginViewController {

    // OUTLETS
    @IBOutlet weak var emailTextField: UITextField! { didSet { emailTextField.addPadding(UITextField.PaddingSide.left(5)) }}
    @IBOutlet weak var passwordTextField: UITextField! { didSet { passwordTextField.addPadding(UITextField.PaddingSide.left(5)) }}
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var recrowdLogo: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.registerButton.backgroundColor =  UIColor(red: 90/255.0, green: 172/255.0, blue: 236/255.0, alpha: 1.0)
        self.loginButton.backgroundColor =  UIColor(red: 186/255.0, green: 221/255.0, blue: 102/255.0, alpha: 1.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
        self.view.layer.insertSublayer(getGradientBackground(), at: 0)
        self.view.bringSubview(toFront: recrowdLogo)
          self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
    }
    
    @IBAction func doEmailLogin(_ sender: UIButton) {
        if let email = emailTextField.text,
            let password = passwordTextField.text {
            
            if (!checkValidCredentials(email: email, password: password)) {
                showErrorMessage(msg: "Invalid input for email or password")
                return
            }
            
            Auth.auth().signIn(withEmail: email, password: password, completion: { user, error in
                if error != nil {
                    self.showErrorMessage(msg: "Login attempt failed: Incorrect credentials")
                    return
                }
                
                self.proceedLogin(user: User())
                print("success login!")
            })
        }
    }
    
    @IBAction func doEmailSignup(_ sender: UIButton) {
        if let email = emailTextField.text,
            let password = passwordTextField.text {
            
            if (!checkValidCredentials(email: email, password: password)) {
                showErrorMessage(msg: "Invalid input for email or password")
                return
            }
            
            Auth.auth().createUser(withEmail: email, password: password, completion: { user, error in
                if error != nil {
                    self.showErrorMessage(msg: "Cannot create account: Already exists")
                    return
                }
                
                self.errorLabel.isHidden = true
            })
        }
    }
    
    private func showErrorMessage(msg: String) {
        emailTextField.text = ""
        passwordTextField.text = ""
        
        errorLabel.isHidden = false
        errorLabel.text = msg
    }
    
    private func checkValidCredentials(email: String, password: String) -> Bool {
        if !email.contains("@") || !email.contains(".") {
            return false
        }
        return email.count >= 8 && password.count >= 8
    }

    
    private func proceedLogin(user: User) {
        self.errorLabel.isHidden = true
        self.passwordTextField.text = ""
        let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: "onboardingComplete"){
            performSegue(withIdentifier: "Incheck", sender: self)
        }else{
            performSegue(withIdentifier: "Onboard", sender: self)
        }
    }
    
}

extension UITextField {
    
    enum PaddingSide {
        case left(CGFloat)
        case right(CGFloat)
        case both(CGFloat)
    }
    
    func addPadding(_ padding: PaddingSide) {
        
        self.leftViewMode = .always
        self.layer.masksToBounds = true
    
        switch padding {
            
        case .left(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.leftView = paddingView
            self.rightViewMode = .always
            
        case .right(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.rightView = paddingView
            self.rightViewMode = .always
            
        case .both(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            // left
            self.leftView = paddingView
            self.leftViewMode = .always
            // right
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
}
