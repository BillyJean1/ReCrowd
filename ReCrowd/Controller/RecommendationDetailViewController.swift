//
//  RecommendationDetailViewController.swift
//  ReCrowd
//
//  Created by Ramon Schriks on 21-12-17.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import UIKit
import CoreLocation

class RecommendationDetailViewController: UIViewController, CLLocationManagerDelegate {
    var recommendation: Recommendation?
    var recommendationWasStarted: Bool?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!

    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var declineButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var routeButton: UIButton!
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonUsability(enabled: recommendationWasStarted != true)
        
        if let rec = self.recommendation {
            self.nameLabel.text = rec.name
            self.pointsLabel.text = "\(rec.points)"
            self.descriptionLabel.text = rec.desc
        }
        
        // Obtain location
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
    }
    
    @IBAction func navigateRecommendation(_ sender: UIButton) {
        if let rec = recommendation {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let recommendationNavigationVC = storyboard.instantiateViewController(withIdentifier: "RecommendationNavigationViewController") as! RecommendationNavigationViewController
            recommendationNavigationVC.recommendation = rec
            self.present(recommendationNavigationVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func stopRecommendation(_ sender: UIButton) {
        RecommendationService.shared.stopStartedRecommendation()
        setButtonUsability(enabled: true)
    }
    
    @IBAction func declineRecommendation(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmAcceptRecommendation(_ sender: UIButton) {
        let alert = UIAlertController(title: "Aanbeveling accepteren", message: "Weet je zeker dat je deze suggestie wil accepteren?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ja", style: .default, handler: { [weak weakSelf = self] action in
            weakSelf?.acceptRecommendation()
        }))
        alert.addAction(UIAlertAction(title: "Nee", style: .default, handler: { action in }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            if let lat = recommendation?.latitude, let lng = recommendation?.longitude {
                let distance = location.distance(from: CLLocation(latitude: lat, longitude: lng))
                self.distanceLabel.text = "Afstand: \(Int(distance)) meter"
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.distanceLabel.text = ""
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied) {
            showLocationDisabledPopUp()
        }
    }
    
    func showLocationDisabledPopUp() {
        let alertController = UIAlertController(title: "Locatiegegevens uitgeschakeld",
                                                message: "Om de afstand tot suggesties te berekenen hebben wij toegang nodig tot uw locatiegegevens.",
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Annuleren", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Instellingen openenen", style: .default) { (action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func acceptRecommendation() {
        if recommendation != nil {
            RecommendationService.shared.startRecommendation(recommendation: recommendation!)
            setButtonUsability(enabled: false)
        }
    }
    
    private func setButtonUsability(enabled: Bool) {
        // Show decline + accept buttons if  recommendation is NOT saved (enabled = false)
        self.acceptButton.isEnabled = enabled
        self.acceptButton.isHidden = !enabled
    
        self.declineButton.isEnabled = enabled
        self.declineButton.isHidden = !enabled
        
        // Show stop + route button if recommendation is saved (enabled = true)
        self.stopButton.isEnabled = !enabled
        self.stopButton.isHidden = enabled
        
        self.routeButton.isEnabled = !enabled
        self.routeButton.isHidden = enabled
    }
}
