//
//  DateService.swift
//  ReCrowd
//
//  Created by Ramon Schriks on 17-01-18.
//  Copyright © 2018 BillyJeanOne. All rights reserved.
//

import Foundation

class DateService {
    public static let shared = DateService()

    public func getDayZoneString() -> String {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        if hour > 6 && hour < 12 {
            return "Goedemorgen"
        } else if hour > 12 && hour < 18 {
            return "Goedemiddag"
        } else if hour > 0 && hour < 6 {
            return "Goedenacht"
        } else {
            return "Goedeavond"
        }
    }
}
