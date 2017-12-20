//
//  RecommendationViewController.swift
//  ReCrowd
//
//  Created by Kevin Broeren on 20/12/2017.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit
import CoreLocation

class RecommendationViewController: UIViewController, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private let zoomFactor = 38.0
    
    override func viewDidLoad() {
        FirebaseService.shared.getCheckedInEvent(completionHandler: { [weak weakSelf = self] (data) in
            if let event = data {
                weakSelf?.showRecommendations(event: event)
            } else {
                // TODO: implement message that user is not checked in, and navigate back to "CheckIn" controller
            }
        })
    }
    
    private func showRecommendations(event: Event) {
        let camera = GMSCameraPosition.camera(withLatitude: event.latitude, longitude: event.longitude, zoom: Float(event.range/zoomFactor))
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        addRecommendationsToMap(mapView: mapView, event: event)
    }
    
    private func addRecommendationsToMap(mapView: GMSMapView, event: Event) {
        RecommendationService.shared.checkForRecommendations(completionHandler: { [weak weakSelf = self] (data) in
            if let recommendations = data {
                for recommendation in recommendations {
                    let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: recommendation.latitude, longitude: recommendation.longitude))
                    marker.title = recommendation.name
                    marker.map = mapView
                }
            }
            weakSelf?.view = mapView
        })
    }
}
