//
//  RewardDetailViewController.swift
//  ReCrowd
//
//  Created by mac on 09-01-18.
//  Copyright © 2018 BillyJeanOne. All rights reserved.
//

import UIKit

class RewardDetailViewController: UIViewController {

    let reward:Reward? = nil
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
    }
    

}
