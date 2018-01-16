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
        getStartedButton.alpha = 0
        onboardingView.dataSource = self
        onboardingView.delegate = self
    }
    
    func onboardingItemsCount() -> Int {
        return 4
    }
    
    func onboardingItemAtIndex(_ index: Int) -> OnboardingItemInfo {
        let backgroundColorOne = UIColor(red: 217/255, green: 72/255, blue: 89/255, alpha: 1)
        let backgroundColorTwo = UIColor(red: 106/255, green: 166/255, blue: 211/255, alpha: 1)
        let backgroundColorThree = UIColor(red: 168/255, green: 200/255, blue: 78/255, alpha: 1)
        let backgroundColorFour = UIColor(red: 255/255, green: 167/255, blue: 20/255, alpha: 1)
        let titleFont = UIFont(name: "AvenirNext-Bold", size: 24)!
        let descriptionFont = UIFont(name: "AvenirNext-Regular", size: 18)!
        return [OnboardingItemInfo(#imageLiteral(resourceName: "Bell"), "Suggesties", "Ontvang suggesties om de drukte in het park te vermijden en punten te sparen! Tevens draag je bij aan Crowd-Control in het park!", #imageLiteral(resourceName: "Bell"), backgroundColorOne, UIColor.white, UIColor.white, titleFont, descriptionFont),OnboardingItemInfo(#imageLiteral(resourceName: "CoinOnboarding"), "Sparen", "Spaar zoveel mogelijk punten om de mooiste beloningen te bemachtigen! Hoe meer punten je spaart, hoe vetter de beloningen worden!", #imageLiteral(resourceName: "CoinOnboarding"), backgroundColorTwo, UIColor.white, UIColor.white, titleFont, descriptionFont),OnboardingItemInfo(#imageLiteral(resourceName: "Bear"), "Beloningen", "Zet deze beloningen in om jou dag in het park nog leuker te maken en verlaat het park altijd met een glimlach!", #imageLiteral(resourceName: "Bear"), backgroundColorThree, UIColor.white, UIColor.white, titleFont, descriptionFont),OnboardingItemInfo(#imageLiteral(resourceName: "Facility"), "Faciliteiten", "Krijg inzicht in de faciliteiten in het park zoals toiletten en EHBO-posten! Hierdoor weet je altijd wat er dicht bij je in de buurt is!", #imageLiteral(resourceName: "Facility"), backgroundColorFour, UIColor.white, UIColor.white, titleFont, descriptionFont)][index]
    }
    
    @IBAction func gotStarted(_ sender: UIButton) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "onboardingComplete")
        userDefaults.synchronize()
    }
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        if index == 3{
            UIView.animate(withDuration: 0.4, animations: {
                self.getStartedButton.alpha = 1
            })
        }
        
        func onboardingWillTransitonToIndex(_ index: Int) {
            if index == 2 {
                if self.getStartedButton.alpha == 1 {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.getStartedButton.alpha = 0
                    })
                }
            }
            
        }
        
    }
}
