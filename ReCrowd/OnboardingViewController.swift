//
//  OnboardingViewController.swift
//  ReCrowd
//
//  Created by mac on 16-01-18.
//  Copyright © 2018 BillyJeanOne. All rights reserved.
//

import UIKit
import paper_onboarding

class OnboardingViewController: UIViewController, PaperOnboardingDataSource, PaperOnboardingDelegate {
    
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var onboardingView: OnboardingView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardingView.dataSource = self
        onboardingView.delegate = self
    }
    
    func onboardingItemsCount() -> Int {
        return 3
    }
    
    func onboardingItemAtIndex(_ index: Int) -> OnboardingItemInfo {
        let backgroundColorOne = UIColor(red: 217/255, green: 72/255, blue: 89/255, alpha: 1)
        let backgroundColorTwo = UIColor(red: 106/255, green: 166/255, blue: 211/255, alpha: 1)
        let backgroundColorThree = UIColor(red: 168/255, green: 200/255, blue: 78/255, alpha: 1)
        
        let titleFont = UIFont(name: "AvenirNext-Bold", size: 24)!
        let descriptionFont = UIFont(name: "AvenirNext-Regular", size: 18)!
        return [OnboardingItemInfo(#imageLiteral(resourceName: "Bell"), "Welcome!", "Cupcake ipsum dolor sit amet. Jelly tootsie roll jelly-o. Gummi bears sweet roll jelly icing cupcake gummi bears soufflé.", #imageLiteral(resourceName: "Bell"), backgroundColorOne, UIColor.white, UIColor.white, titleFont, descriptionFont),OnboardingItemInfo(#imageLiteral(resourceName: "brush"), "A Great Rocket Start", "Cupcake ipsum dolor sit amet. Jelly tootsie roll jelly-o. Gummi bears sweet roll jelly icing cupcake gummi bears soufflé.", #imageLiteral(resourceName: "brush"), backgroundColorTwo, UIColor.white, UIColor.white, titleFont, descriptionFont),OnboardingItemInfo(#imageLiteral(resourceName: "Bear"), "A Great Rocket Start", "Cupcake ipsum dolor sit amet. Jelly tootsie roll jelly-o. Gummi bears sweet roll jelly icing cupcake gummi bears soufflé.", #imageLiteral(resourceName: "Bear"), backgroundColorThree, UIColor.white, UIColor.white, titleFont, descriptionFont) ][index]
    }
    
    @IBAction func gotStarted(_ sender: UIButton) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "onboardingComplete")
        userDefaults.synchronize()
    }
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        if index == 2{
            UIView.animate(withDuration: 0.4, animations: {
                self.getStartedButton.alpha = 1
            })
        }
        
        func onboardingWillTransitonToIndex(_ index: Int) {
            if index == 1 {
                if self.getStartedButton.alpha == 1 {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.getStartedButton.alpha = 0
                    })
                }
            }
            
        }
        
    }
}
