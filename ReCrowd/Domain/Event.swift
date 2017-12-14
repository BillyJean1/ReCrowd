//
//  Event.swift
//  ReCrowd
//
//  Created by Kevin Broeren on 14/12/2017.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import UIKit

class Event: NSObject {
    
    public var name: String
    public var id: Int
    public var coordinates: String
    
    init(named name: String, withId: Int, withCoordinates coordinates: String) {
        self.name = name
        self.id = id
        self.coordinates = coordinates
    }
    
}
