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
    public var range:Double
    public var start:TimeInterval
    public var end:TimeInterval
    
    init(withId id: Int, named name: String, withLongitude longitude: Double, withLatitude latitude: Double, range:Double, start:TimeInterval, end:TimeInterval) {
        self.id = id
        self.name = name
        self.longitude = longitude
        self.latitude = latitude
        self.range = range
        self.start = start
        self.end = end
    }
}
