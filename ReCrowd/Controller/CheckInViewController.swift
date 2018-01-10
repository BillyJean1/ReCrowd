//
//  CheckInViewController.swift
//  ReCrowd
//
//  Created by Kevin Broeren on 14/12/2017.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import UIKit

class CheckInViewController: UIViewController {
    
    public var user: User? // Guys, waarvoor is deze variabelen nuttig?
    private var detectedEvent: Event?
    
    @IBOutlet weak var locatieDisplay: UILabel!
    
    @IBOutlet weak var iHaveATicketButton: UIButton!
    @IBOutlet weak var iHaveNoTicketButton: UIButton!
    
// performSegue(withIdentifier: "Recommendations", sender: self)
    
    override func viewDidLoad() {
        FirebaseService.shared.getCheckedInEvent(completionHandler: { [weak weakSelf = self] (event) in
            let userIsAlreadyCheckedIn = event != nil
            if userIsAlreadyCheckedIn {
                CheckInService.shared.currentCheckedInEvent = event
                self.performSegue(withIdentifier: "Recommendations", sender: self)
            } else {
                NotificationCenter.default.addObserver(self, selector: #selector(self.showDetectedEvent), name: CheckInService.shared.updatedEventInRangeNotificationName, object: nil)
                CheckInService.shared.updateEventInRange()
            }
        })
        
    }
    
    @IBAction func iHaveATicketButtonPressed(_ sender: UIButton) {
        if let detectedEvent = CheckInService.shared.eventInRange {
            print("CheckInViewController :: iHaveATicketButtonPressed() -> notImplementedYet");
            // MARK: Hier kan de code om het ticket te scannen dus. Vervolgens dient de checkIn methode uitgevoerd te worden: checkIn(atEvent: detectedEvent)
        }
    }
    
    @IBAction func iHaveNoTicketButtonPressed(_ sender: UIButton) {
        if let detectedEvent = CheckInService.shared.eventInRange {
            checkIn(atEvent: detectedEvent)
        }
    }
    
    func checkIn(atEvent event: Event){
        CheckInService.shared.checkIn(atEvent: event)
        performSegue(withIdentifier: "Recommendations", sender: self)
    }

    @objc func showDetectedEvent() {
        if let detectedEvent = CheckInService.shared.eventInRange {
            locatieDisplay.text = "We hebben gedetecteerd dat je je in de \(detectedEvent.name) bevindt."
        }
    }
    
    @IBAction func unwindToCheckinVC(segue:UIStoryboardSegue) { }
}
