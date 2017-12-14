//
//  CheckInViewController.swift
//  ReCrowd
//
//  Created by Kevin Broeren on 14/12/2017.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import UIKit

class CheckInViewController: UIViewController {
    
    private var eventInRange: Event

    func checkIn() {
        CheckInService.shared.checkIn()
    }
    
    func confirmEvent(eventInRange: Event) {
        CheckInService.shared.registerCheckIn(eventInRange)
    }
    
}
