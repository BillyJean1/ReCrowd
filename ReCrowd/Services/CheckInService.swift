//
//  CheckInService.swift
//  ReCrowd
//
//  Created by Kevin Broeren on 14/12/2017.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import UIKit

class CheckInService {
    public static let shared = CheckInService()

    private init() {}
    
    public func checkIn() -> Event {
        LocationService.shared.getLocation()
        let eventInRange: Event = getEventInRange()
        return eventInRange
    }
    
    private func getEventInRange() -> Event {
        FirebaseService.shared.getEvents(completionHandler: {_ in
            //Hier iets doen wanneer er events terugkomen
        })

        return Event(withId: 1, named: "Example event", withLongitude: 1.0001, withLatitude: 1.5, range: 600, start: NSDate().timeIntervalSince1970, end: NSDate().timeIntervalSince1970) // TODO: This is an example event.
    }

    public func registerCheckIn(withEvent eventInRange: Event) {
        FirebaseService.shared.registerCheckIn(withEvent: eventInRange)
    }

}
