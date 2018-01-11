//
//  MapService.swift
//  ReCrowd
//
//  Created by Ramon Schriks on 11-01-18.
//  Copyright © 2018 BillyJeanOne. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class MapService {
    public static let shared = MapService()
    
    // Image icon resources
    private static let recommendationMarkerImage = "placeholder"
    private static let toiletImage = "toilet"
    private static let ehboImage = "ehbo"
    private static let defaultImage = "question"

    public func setRecommendationMarker(mapView: GMSMapView, recommendation: Recommendation) {
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: recommendation.latitude, longitude: recommendation.longitude))
        
        marker.icon = UIImage(named: MapService.recommendationMarkerImage)
        marker.title = recommendation.name
        marker.userData = recommendation
        marker.map = mapView
    }
    
    public func setFacilityMarker(mapView: GMSMapView, facility: Facility) {
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: facility.latitude, longitude: facility.longitude))
        
        var icon: String?
        switch facility.type {
        case "toilet":
            icon = MapService.toiletImage
        case "ehbo":
            icon = MapService.ehboImage
        default:
            icon = MapService.defaultImage
        }
        
        marker.icon = UIImage(named: icon!)
        marker.title = facility.name
        marker.userData = facility
        marker.map = mapView
    }
}
