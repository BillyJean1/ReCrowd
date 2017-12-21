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

class RecommendationViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    private let locationManager = CLLocationManager()
    private let zoomFactor = 38.0
    
    override func viewDidLoad() {
        loadRecommendations()
    }

    private func loadRecommendations() {
        FirebaseService.shared.getCheckedInEvent(completionHandler: { [weak weakSelf = self] (event) in
            if event != nil {
                weakSelf?.showRecommendations(event: event!)

                if let startedRecommendation = RecommendationService.shared.getStartedRecommendation() {
                    weakSelf?.segueToRecommendationDetail(recommendation: startedRecommendation, isStarted: true)
                }
            } else {
                weakSelf?.alertUserNotCheckedIn()
            }
        })
    }
    
    private func showRecommendations(event: Event) {
        let camera = GMSCameraPosition.camera(withLatitude: event.latitude, longitude: event.longitude, zoom: Float(event.range/zoomFactor))
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.delegate = self
        
        addRecommendationsToMap(mapView: mapView, event: event)
    }
    
    private func addRecommendationsToMap(mapView: GMSMapView, event: Event) {
        RecommendationService.shared.checkForRecommendations(completionHandler: { [weak weakSelf = self] (data) in
            if let recommendations = data {
                for recommendation in recommendations {
                    let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: recommendation.latitude, longitude: recommendation.longitude))
                    marker.title = recommendation.name
                    marker.userData = recommendation
                    marker.map = mapView
                }
            }
            weakSelf?.view = mapView
        })
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        if let recommendation = marker.userData as? Recommendation {
            segueToRecommendationDetail(recommendation: recommendation)
        }
    }
    
    private func alertUserNotCheckedIn() {
        let alert = UIAlertController(title: "Niet ingechecked", message: "U lijkt momenteel niet ingechecked bij een evenement. U wordt terug gestuurd naar het incheck scherm.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak weakSelf = self] action in
            weakSelf?.performSegue(withIdentifier: "unwindToCheckinVC", sender: self)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func segueToRecommendationDetail(recommendation: Recommendation, isStarted: Bool = false) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let recommendationVC = storyboard.instantiateViewController(withIdentifier: "RecommendationDetailViewController") as! RecommendationDetailViewController
        recommendationVC.recommendation = recommendation
        recommendationVC.recommendationWasStarted = isStarted
        self.present(recommendationVC, animated: true, completion: nil)
    }
}
