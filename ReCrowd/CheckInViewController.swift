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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func checkIn() {
        eventInRange = CheckInService.shared.checkIn()
    }
    
    func confirmEvent(withEvent eventInRange: Event) {
        CheckInService.shared.registerCheckIn(withEvent: eventInRange)
    }
    
}
