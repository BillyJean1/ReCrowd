//
//  Recommendation.swift
//  ReCrowd
//
//  Created by Ramon Schriks on 19-12-17.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import Foundation

class Recommendation {
    let points: Int?
    let name: String?
    let longitude: Double?
    let latitude: Double?
    let description: String?
    
    init(withName name: String, withPoint points: Int, withLongitude lng: Double, withLatitude lat: Double, withDescription desc: String) {
        self.points = points
        self.name = name
        self.latitude = lat
        self.longitude = lng
        self.description = desc
    }
}
