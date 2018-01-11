//
//  Facility.swift
//  ReCrowd
//
//  Created by Ramon Schriks on 10-01-18.
//  Copyright © 2018 BillyJeanOne. All rights reserved.
//

import Foundation

class Facility {
    public var name: String
    public var description: String
    public var type: String
    public var latitude: Double
    public var longitude: Double
    
    init(name: String, description: String, type: String, latitude: Double, longitude: Double) {
        self.name = name
        self.description = description
        self.type = type
        self.longitude = longitude
        self.latitude = latitude
    }
}
