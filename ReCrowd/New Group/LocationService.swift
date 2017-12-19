//
//  LocationService.swift
//  ReCrowd
//
//  Created by Kevin Broeren on 14/12/2017.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import UIKit
import CoreLocation

class LocationService: NSObject {
    
    public static let shared = LocationService()
    private var currentLocation: CLLocation = CLLocation()
    private var locationManager: CLLocationManager = CLLocationManager()
    
    override private init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 10 // The minimum distance (measured in meters) a device must move horizontally before an update event is generated.
        locationManager.delegate = self
    }
    
    func getLocation() {
         locationManager.requestAlwaysAuthorization() // Need always: because we want to suggest suggestions while the app is in the background.
        locationManager.requestLocation()
    }

}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last!
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
