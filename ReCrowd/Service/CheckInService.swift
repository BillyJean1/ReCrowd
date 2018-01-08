//
//  CheckInService.swift
//  ReCrowd
//
//  Created by Kevin Broeren on 14/12/2017.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import UIKit
import CoreLocation

class CheckInService: NSObject {
    
    /* Property to access this shared instance. */
    public static let shared = CheckInService()
    
    /* Location Variables */
    public var currentLocation = CLLocation()
    public var eventInRange: Event?
    private var locationManager = CLLocationManager()
    
    /* Notification Variables */
    let updatedEventInRangeNotificationName = Notification.Name("updatedEventInRangeNotification")
    let updatedEventInRangeNotification:Notification
    
    private override init() {
        updatedEventInRangeNotification = Notification.init(name: self.updatedEventInRangeNotificationName)
    }
    
    public func updateEventInRange() {
        print("CheckInService :: Updating event in range.")
        updateCurrentLocation()
    }
    
    public func checkIn(atEvent event: Event) {
        print("CheckInService :: Checking you in at \(event.name).")
        FirebaseService.shared.registerCheckIn(atEvent: event)
    }
    
    private func updateCurrentLocation() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
    }
    
    @objc private func getEventInRange(completionHandler: @escaping (_ event: Event?) -> ()) {
        FirebaseService.shared.getEvents(completionHandler: {events in
            
            let eventsSortedByClosestDistanceToFurthestDistance = events.sorted(by: { compareableEvent1, compareableEvent2 in
                self.currentLocation.distance(from: CLLocation(latitude: compareableEvent1.latitude, longitude: compareableEvent1.longitude))
                    < self.currentLocation.distance(from: CLLocation(latitude: compareableEvent2.latitude, longitude: compareableEvent2.longitude))
            })
            
            let eventWithClosestDistance = eventsSortedByClosestDistanceToFurthestDistance[0]
            
            if (self.currentLocation.distance(from: CLLocation(latitude: eventWithClosestDistance.latitude, longitude: eventWithClosestDistance.longitude)) <= eventWithClosestDistance.range) {
                completionHandler(eventWithClosestDistance)
            } else {
                completionHandler(nil)
            }
            
            
            
        })
    }
}

extension CheckInService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            currentLocation = location
            getEventInRange(completionHandler: { newEventInRange in
                self.eventInRange = newEventInRange
                NotificationCenter.default.post(self.updatedEventInRangeNotification)
            })
        }
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
        case .notDetermined:
            print("Location status not determined.")
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
}
