//
//  Event.swift
//  ReCrowd
//
//  Created by Kevin Broeren on 14/12/2017.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import UIKit

class Event: NSObject {
    public var id: Int
    public var name: String
    public var longitude: Double
    public var latitude: Double
    
    init(withId id: Int, named name: String, withLongitude longitude: Double, withLatitude latitude: Double) {
        self.id = id
        self.name = name
        self.longitude = longitude
        self.latitude = latitude
    }
    
}
