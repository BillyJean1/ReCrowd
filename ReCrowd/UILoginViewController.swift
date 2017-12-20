//
//  LoginController.swift
//  ReCrowd
//
//  Created by Ramon Schriks on 18-12-17.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import Foundation
import Font_Awesome_Swift

class UILoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getGradientBackground() -> CAGradientLayer {
        let colorTop =  UIColor(red: 151.0/255.0, green: 215.0/255.0, blue: 243.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 18.0/255.0, green: 107.0/255.0, blue: 189.0/255.0, alpha: 1.0).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ colorTop, colorBottom]
        gradientLayer.locations = [ 0.0, 1.0]
        gradientLayer.frame = CGRect(x:0, y: 0, width: self.view.frame.width, height:self.view.frame.height/1.5)
        
        return gradientLayer
    }
}
