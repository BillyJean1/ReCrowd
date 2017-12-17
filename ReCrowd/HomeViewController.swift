//
//  HomeViewController.swift
//  ReCrowd
//
//  Created by Ramon Schriks on 13-12-17.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    public var user: User?
    
    override func viewDidLoad() {
       print(user?.id ?? "lol no user")
    }
}
