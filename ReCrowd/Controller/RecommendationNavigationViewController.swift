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
    var mapView: GMSMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let lat = recommendation?.latitude, let lng = recommendation?.longitude {
            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: 16)
            self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
            view = self.mapView
        }
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
    }
    
    func route(startLocation: CLLocation, recommendation: Recommendation) {
        if self.mapView == nil {
            return;
        } else {
            self.mapView?.clear()
        }
        
        let origin = "\(startLocation.coordinate.latitude),\(startLocation.coordinate.longitude)"
        let destination = "\(recommendation.latitude),\(recommendation.longitude)"
        let urlString = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=walking&key=AIzaSyDm4djGvXBHtfJlaa__ggI3chJf5fs_E7M"
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            if(error != nil){
                print("error")
            }else{
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                    let routes = json["routes"] as! NSArray
                    
                    OperationQueue.main.addOperation({
                        for route in routes
                        {
                            let routeOverviewPolyline:NSDictionary = (route as! NSDictionary).value(forKey: "overview_polyline") as! NSDictionary
                            let points = routeOverviewPolyline.object(forKey: "points")
                            let path = GMSPath.init(fromEncodedPath: points! as! String)
                            let polyline = GMSPolyline.init(path: path)
                            polyline.strokeWidth = 3
                            
                            let bounds = GMSCoordinateBounds(path: path!)
                            self.mapView!.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 30.0))
                            
                            polyline.map = self.mapView
                            
                        }
                    })
                }catch let error as NSError{
                    print("error:\(error)")
                }
            }
        }).resume()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            if let view = view as? GMSMapView {

                if let recommendation = self.recommendation {
                    self.route(startLocation: location, recommendation: recommendation)
                }
                
                marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                marker.map = view
                view.camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 16)
            }
        }
    }
}
