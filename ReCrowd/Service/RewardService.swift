//
//  RewardService.swift
//  ReCrowd
//
//  Created by Ramon Schriks on 09-01-18.
//  Copyright © 2018 BillyJeanOne. All rights reserved.
//

import Foundation

class RewardService {
    public static let shared = RewardService()
    public static let rewardPointsDefaultKey = "reward_points"
    
    public func getCurrentRewardPointsForUser() -> Int {
        return UserDefaults.standard.integer(forKey: RewardService.rewardPointsDefaultKey)
    }
    
    @objc public func getRewardForEvent(completionHandler: @escaping (_ reward: Reward) -> (), id:Int) {
        FirebaseService.shared.getRewardForEvent(completionHandler:  { (reward) in
            completionHandler(reward)
        }, id: id)
    }
    
    @discardableResult
    public func addRewardPointsForUser(add: Int) -> Int {
        let currentRewardPoints = self.getCurrentRewardPointsForUser()
        let newRewardPoints = currentRewardPoints + add
        UserDefaults.standard.set(newRewardPoints, forKey: RewardService.rewardPointsDefaultKey)
        return newRewardPoints
    }
    
    @discardableResult
    public func decreaseRewardPointsForUser(by number: Int) -> Int {
        let currentRewardPoints = self.getCurrentRewardPointsForUser()
        let newRewardPoints = currentRewardPoints + number
        UserDefaults.standard.set(newRewardPoints, forKey: RewardService.rewardPointsDefaultKey)
        return newRewardPoints
    }
}
