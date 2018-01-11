//
//  Reward.swift
//  ReCrowd
//
//  Created by Kevin Broeren on 09/01/2018.
//  Copyright © 2018 BillyJeanOne. All rights reserved.
//

import Foundation

class Reward: NSObject, NSCoding {
    public var name: String
    public var _description: String
    public var cost: Int
    
    init(named name: String, withDescription description: String, withCost cost: Int) {
        self.name = name
        self._description = description
        self.cost = cost
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(_description, forKey: "_description")
        aCoder.encode(cost, forKey: "cost")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let _description = aDecoder.decodeObject(forKey: "_description") as! String
        let cost = aDecoder.decodeInteger(forKey: "cost") 
        self.init(named: name, withDescription: _description, withCost: cost)
    }
}
