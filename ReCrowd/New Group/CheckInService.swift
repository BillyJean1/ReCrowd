//
//  CheckInService.swift
//  ReCrowd
//
//  Created by Kevin Broeren on 14/12/2017.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import UIKit

class CheckInService: NSObject {
    
    public static let shared = CheckInService()
    
    private override init() {}
    
    public func checkIn() {
        LocationService.shared.getLocation()
        let eventInRange = getEventInRange()
        return eventInRange
    }
    
    private func getEventInRange() {
        FirebaseService.shared.getEvents()
        // return
    }
    
    private func registerCheckIn(eventInRange: Event) {
        FirebaseService.shared.registerCheckIn(eventInRange)
    }

}
