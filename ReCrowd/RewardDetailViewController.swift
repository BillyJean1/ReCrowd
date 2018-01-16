//
//  RewardDetailViewController.swift
//  ReCrowd
//
//  Created by mac on 09-01-18.
//  Copyright © 2018 BillyJeanOne. All rights reserved.
//

import UIKit

class RewardDetailViewController: UIViewController {

    var image: UIImage?
    @IBOutlet weak var rewardDetailImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
 self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        if image != nil{
            self.rewardDetailImage.image = image
        }
    self.navigationController?.navigationBar.isTranslucent = true

        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @IBAction func back(_ sender: UIButton) {
        performSegue(withIdentifier: "RewardsOverview", sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "RewardsOverview"){
            if let destination = segue.destination as? HomeViewController{
                    //destination.addCoin()
            }
        }
    }
    

}
