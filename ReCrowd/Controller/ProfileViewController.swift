//
//  ProfileViewController.swift
//  ReCrowd
//
//  Created by Colin van der Geld on 15-01-18.
//  Copyright © 2018 BillyJeanOne. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: RewardCollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rewards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reward", for: indexPath) as! RewardCollectionViewCell
        
        let imageString = getCorrectImageString(index: indexPath.row)
        cell.rewardImage.image = UIImage(named: imageString)
        return cell
    }
    
    private func getCorrectImageString(index : Int) -> String{
        let reward = rewards[index]
        
        switch reward.name {
        case "Fast-lane":
            return "FastlaneTicketButton"
        case "Knuffel":
            return "KnuffelButton"
        case "Consumptie":
            return "ConsumptieButton"
        case "Korting":
            return "KortingButton"
        case "Backstage":
            return "BackstageButton"
        case "Show":
            return "ShowButton"
        default:
            return "noImage"
        }
        
    }
    
    private let reuseIdentifier = "reward"
    private var rewards:[Reward] = [Reward]()
    
    
    @IBOutlet weak var totalPoints: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        totalPoints.text = "\(RewardService.shared.getCurrentRewardPointsForUser())"
        
        
        rewards = RewardService.shared.getRewards()
        collectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
