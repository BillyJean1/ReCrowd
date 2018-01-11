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
    
    
    public static let rewardsSavedKey = "saved_rewards"
    
    private let userDefaults = UserDefaults.standard
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
    
    
    
    
    
    
    public func getRewards() -> [Reward]  {
      
        let data = userDefaults.object(forKey: RewardService.rewardsSavedKey)
        if let decodedData = data as? Data {
            if let decodedRewards = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as? [Reward] {
                return decodedRewards
            }
        }
        return []
    }
    
    public func addReward(reward: Reward) {
        var currentRewards:[Reward]
        
        if userDefaults.object(forKey: RewardService.rewardsSavedKey) != nil {
            currentRewards = getRewards()
        }
        else{
            currentRewards = [Reward]()
        }
        
        currentRewards.append(reward)
        
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: currentRewards)
        userDefaults.setValue(encodedData, forKey: RewardService.rewardsSavedKey)
        userDefaults.synchronize()
    }
    
    public func deleteReward(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
    
    
    
    
    
}
