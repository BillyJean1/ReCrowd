//
//  Recommendation.swift
//  ReCrowd
//
//  Created by Ramon Schriks on 19-12-17.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import Foundation

class Recommendation: NSObject, NSCoding  {
    public var points: Int
    public var name: String
    public var longitude: Double
    public var latitude: Double
    public var desc: String
    
    init(withName name: String, withPoint points: Int, withLongitude lng: Double, withLatitude lat: Double, withDescription desc: String) {
        self.points = points
        self.name = name
        self.latitude = lat
        self.longitude = lng
        self.desc = desc
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let points = aDecoder.decodeInteger(forKey: "points")
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let longitude = aDecoder.decodeDouble(forKey: "longitude")
        let latitude = aDecoder.decodeDouble(forKey: "latitude")
        let desc = aDecoder.decodeObject(forKey: "desc") as! String
        self.init(withName: name, withPoint: points, withLongitude: longitude, withLatitude: latitude, withDescription: desc)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(points, forKey: "points")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(longitude, forKey: "longitude")
        aCoder.encode(latitude, forKey: "latitude")
        aCoder.encode(desc, forKey: "desc")
    }
}
