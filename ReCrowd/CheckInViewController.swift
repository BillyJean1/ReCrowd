//
//  CheckInViewController.swift
//  ReCrowd
//
//  Created by Kevin Broeren on 14/12/2017.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import UIKit
import AVFoundation

class CheckInViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    // OUTLETS
    @IBOutlet weak var welEenTicketButton: UIButton!
    @IBOutlet weak var nietEenTicketButton: UIButton!
    
    // LOCATION CHECK-IN
    private var eventInRange: Event?

    override func viewDidLoad() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    
    }
    
    public func checkIn() {
        eventInRange = CheckInService.shared.checkIn()
    }
    
    public func confirmEvent(withEvent eventInRange: Event) {
        CheckInService.shared.registerCheckIn(withEvent: eventInRange)
    }
    
    @IBAction func doTicketScan(_ sender: UIButton) {
        // TODO: poc kevin in mergen
        performSegue(withIdentifier: "Home", sender: self)
    }

    @IBAction func doTicketlessCheckIn(_ sender: UIButton) {
        performSegue(withIdentifier: "Home", sender: self)
    }
    
}
