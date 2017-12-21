//
//  RecommendationNavigationViewController.swift
//  ReCrowd
//
//  Created by Ramon Schriks on 21-12-17.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import MapKit

class RecommendationNavigationViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()

    var recommendation: Recommendation?
    var marker = GMSMarker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let lat = recommendation?.latitude, let lng = recommendation?.longitude {
            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: 16)
            let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
            view = mapView
        }
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            if let view = view as? GMSMapView {
                marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                marker.map = view
                view.camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 16)
            }
        }
    }
}
