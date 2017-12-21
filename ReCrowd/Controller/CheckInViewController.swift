//
//  CheckInViewController.swift
//  ReCrowd
//
//  Created by Kevin Broeren on 14/12/2017.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import UIKit

class CheckInViewController: UIViewController {
    
    public var user: User?
    
    private var eventInRange: Event?
    
    @IBAction func checkMeIn(_ sender: UIButton) {
        checkIn()
        performSegue(withIdentifier: "Recommendations", sender: self)
    }
    
    public func checkIn() {
        eventInRange = CheckInService.shared.checkIn()
    }
    
    public func confirmEvent(withEvent eventInRange: Event) {
        CheckInService.shared.registerCheckIn(withEvent: eventInRange)
    }
    
    @IBAction func unwindToCheckinVC(segue:UIStoryboardSegue) { }
}
