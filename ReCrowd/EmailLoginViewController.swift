//
//  EmailLoginViewController.swift
//  ReCrowd
//
//  Created by mac on 17-12-17.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import UIKit
import Firebase

class EmailLoginViewController: UIViewController {

    // OUTLETS
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func doEmailLogin(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil{
                print("\(error!)")
            }else {
                print("Signed in!")
                self.performSegue(withIdentifier: "Home", sender: self)
            }
            
        }
    }
    
    @IBAction func doEmailSignup(_ sender: UIButton) {
     
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil{
                print("\(error!)")
            }else {
                print("Created user!")
                self.performSegue(withIdentifier: "Home", sender: self)
            }
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //TODO: Implement
    }


}
