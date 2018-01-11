//
//  RewardDetailViewController.swift
//  ReCrowd
//
//  Created by mac on 09-01-18.
//  Copyright © 2018 BillyJeanOne. All rights reserved.
//

import UIKit

class RewardDetailViewController: UIViewController {

    var reward:Reward? = nil
    var imageName:String = ""
    
    @IBOutlet weak var buyRewardButton: UIButton!
    @IBOutlet weak var rewardImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var coinIcon: UIImageView!
    @IBOutlet weak var rewardDescription: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        setUpImages()
        // Do any additional setup after loading the view.
    }

    
    private func setUpImages(){
        coinIcon.image = UIImage(named: "CoinIcon")
        rewardImage.image = UIImage(named: imageName)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buyReward(_ sender: UIButton) {
        let alert = UIAlertController(title: "Item kopen", message: "Weet u zeker dat u dit item wilt kopen?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Nee", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Ja", style: .default, handler:
            { (_) in
                RewardService.shared.decreaseRewardPointsForUser(by: (self.reward?.cost)!)
                RewardService.shared.addReward(reward: self.reward!)
                
                let alert2 = UIAlertController(title:"Gekocht", message: "Item aangeschaft!", preferredStyle: .alert)
                alert2.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert2, animated: true, completion: nil)
                
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    

}
