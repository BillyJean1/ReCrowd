//
//  FirebaseService.swift
//  ReCrowd
//
//  Created by Kevin Broeren on 14/12/2017.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import UIKit
import Firebase

class FirebaseService: NSObject {
    var ref: DatabaseReference!
    
    public static let shared = FirebaseService()
    
    private override init() {
         ref = Database.database().reference()
    }
    
    func getEvents() {
        // Firebase shit
    }
    
    func registerCheckIn(withEvent eventInRange: Event) {
        self.ref.child("events").child("\(eventInRange.id)").setValue(["name":eventInRange.name, "coordinates":eventInRange.coordinates])
        // Firebase stuff (tududu du du duu (tudu du du du duu)
    }

}
