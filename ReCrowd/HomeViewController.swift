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
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.addCoin()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.addCoin()
           self.navigationController?.navigationBar.topItem?.title = "Beloningen"
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController!.navigationBar.barTintColor = UIColor(red: 255/255.0, green: 167/255.0, blue: 20/255.0, alpha: 1.0)
        
    }
    
    func addCoin (){
        let coin = UIButton(type: .custom)
        coin.setImage(#imageLiteral(resourceName: "CoinIcon"), for: .normal)
        coin.tintColor = UIColor.white
        coin.frame = CGRect(x: 2, y: 74, width: 140, height: 40)
        coin.imageEdgeInsets = UIEdgeInsets(top: 6, left: 100, bottom: 6, right: 14)
        coin.titleEdgeInsets = UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 20)
        // MARKER: hier zet je de coins van de user in de navbar
        coin.setTitle("300", for: .normal)
        
        // add action?
        let coinItem = UIBarButtonItem(customView: coin)
        self.navigationController!.navigationBar.topItem?.setRightBarButtonItems([coinItem], animated: true)
    }

    @IBAction func goToRewardDetailView(_ sender: UIButton) {
        performSegue(withIdentifier: "RewardDetails", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "RewardDetails"){
            if let destination = segue.destination as? RewardDetailViewController{
                destination.hidesBottomBarWhenPushed = true
                if let button = sender as? UIButton{
                    destination.image = button.currentImage
                }
            }
        }
    }
    
}
