//
//  RewardViewController.swift
//  ReCrowd
//
//  Created by Colin van der Geld on 11-01-18.
//  Copyright © 2018 BillyJeanOne. All rights reserved.
//

import UIKit

class RewardViewController: UIViewController {
    var buttonId = 0
    @IBAction func rewardButtonPressed(_ sender: UIButton) {
        buttonId = sender.tag
        performSegue(withIdentifier: "RewardDetails", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? RewardDetailViewController{
        RewardService.shared.getRewardForEvent(completionHandler: {reward in
            destinationVC.priceLabel.text = "\(reward.cost)"
            destinationVC.rewardDescription.text = "\(reward._description)"
            destinationVC.reward = reward
            let rewardPoints = RewardService.shared.getCurrentRewardPointsForUser()
            print("Current reward points for this user: \(rewardPoints)")
            if rewardPoints < reward.cost{
                destinationVC.buyRewardButton.isEnabled = false
                destinationVC.buyRewardButton.alpha = 0.5
            }
            
            
        }, id: (buttonId-1))
            
        switch buttonId{
        case 1:
            //Fast-lane ticket
            destinationVC.imageName = "FastlaneTicketButton"
        case 2:
            //Knuffel
            destinationVC.imageName = "KnuffelButton"
        case 3:
            //Consumptie
            destinationVC.imageName = "ConsumptieButton"
        case 4:
            //Korting
            destinationVC.imageName = "KortingButton"
        case 5:
            //Backstage
            destinationVC.imageName = "BackstageButton"
        case 6:
            //Show
            destinationVC.imageName = "ShowButton"
        default:
            print("No tag found.")
            }
        }
    }
}
