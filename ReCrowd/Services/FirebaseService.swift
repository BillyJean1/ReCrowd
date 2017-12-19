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
    
    func getEventsByUID() -> [Event]? {
        if let uid = Auth.auth().currentUser?.uid {
            // TODO: implement retrieval of Events by
        }
        return nil
    }
    
    func getCheckedInEvent() -> Event? {
        if let events = self.getEventsByUID() {
            // TODO: Check which is checked in at latest
        }
        return nil
    }
    
    func getEventRecommendations() -> [Recommendation]? {
        if let event = self.getCheckedInEvent() {
            // TODO: implement retrieval of recommendations linked to the event.
        }
        return nil
    }
    
    func registerCheckIn(withEvent eventInRange: Event) {
        self.ref.child("events").child("\(eventInRange.id)").setValue(["name":eventInRange.name, "longitude":eventInRange.longitude, "latitude":eventInRange.latitude])
        
        self.ref.child("checkIns").setValue(["uid":user?.id!,"event_id":eventInRange.id])
    }
}
