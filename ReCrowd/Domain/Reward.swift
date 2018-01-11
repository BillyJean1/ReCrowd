//
//  Reward.swift
//  ReCrowd
//
//  Created by Kevin Broeren on 09/01/2018.
//  Copyright © 2018 BillyJeanOne. All rights reserved.
//

import Foundation

class Reward: NSObject {
    public var name: String
    public var _description: String
    public var cost: Int
    
    init(named name: String, withDescription description: String, withCost cost: Int) {
        self.name = name
        self._description = description
        self.cost = cost
    }
}
