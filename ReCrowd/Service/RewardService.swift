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
    
    public func getRewardPoints() -> Int {
        return UserDefaults.standard.integer(forKey: RewardService.rewardPointsDefaultKey)
    }
    
    public func addRewardPoints(add: Int) -> Int {
        let currentRewardPoints = self.getRewardPoints()
        let newRewardPoints = currentRewardPoints + add
        UserDefaults.standard.set(newRewardPoints, forKey: RewardService.rewardPointsDefaultKey)
        return newRewardPoints
    }
}
