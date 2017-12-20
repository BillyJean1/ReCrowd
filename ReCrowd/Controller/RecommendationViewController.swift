//
//  RecommendationViewController.swift
//  ReCrowd
//
//  Created by Kevin Broeren on 20/12/2017.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import UIKit

class RecommendationViewController: UIViewController {
    
    override func viewDidLoad() {
        print("RecommendationViewController :: viewDidLoad()")
        RecommendationService.shared.checkForRecommendations()
    }
    
}
