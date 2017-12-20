//
//  FirebaseService.swift
//  ReCrowd
//
//  Created by Kevin Broeren on 14/12/2017.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase // Kevin: We need to find out why this is needed but not needed :D

/*
 FaceBook UserID Kevin: D07p3uNKGURx5DorWgHDQVr9Fdp2
 */

class FirebaseService: NSObject {
    private var ref: DatabaseReference!
    
    public var user:User?
    public static let shared = FirebaseService()
    
    private override init() {
        ref = Database.database().reference()
    }
    
    func getEvents() -> [Event] {
        // Firebase shit
        return []
    }
    
    func getCheckedInEvent() -> Event? {
        print("FirebaseService :: getCheckedInEvent()")
        var checkedinEvent: Event?
        if let uid = Auth.auth().currentUser?.uid {
            ref.child("check-ins").child("user-" + uid).child("checkin").child("event").observeSingleEvent(of: .value, with: { (snapshot) in
                checkedinEvent = snapshot.value as? NSObject
            }) { (error) in
                print(error.localizedDescription)
            }
        }
        return checkedinEvent
    }
    
    func getEventRecommendations() -> [Recommendation]? {
        print("FirebaseService :: checkForRecommendations()")
        if let event = getCheckedInEvent() {
            print(event)
        }
        return nil
    }
    
    func registerCheckIn(withEvent eventInRange: Event) {
        self.ref.child("events").child("\(eventInRange.id)").setValue(["name":eventInRange.name, "longitude":eventInRange.longitude, "latitude":eventInRange.latitude])
        
        self.ref.child("checkIns").setValue(["uid":user?.id!,"event_id":eventInRange.id])
    }
}
