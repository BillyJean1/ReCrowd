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
    
    public func checkIn() -> Event {
        LocationService.shared.getLocation()
        let eventInRange: Event = getEventInRange()
        return eventInRange
    }
    
    private func getEventInRange() -> Event {
        FirebaseService.shared.getEvents()
        return Event(named: "Example event", withId: 1, withCoordinates: "example") // TODO: This is an example event.
    }
    
    public func registerCheckIn(withEvent eventInRange: Event) {
        FirebaseService.shared.registerCheckIn(withEvent: eventInRange)
    }

}
