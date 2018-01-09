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
    
    func getRewardsForEvent(completionHandler: @escaping (_ rewards: [Reward]) -> ()) {
        var rewards = [Reward]()
        getCheckedInEvent(completionHandler: { [weak self] (event) in
            print("We are gonna get the rewards for event id '\(event!.id)' rewards.")
            self?.ref.child("rewards").child("event-\(event!.id)").observeSingleEvent(of: .value, with: { (snapshot) in
                let enumerator = snapshot.children
                while let rest = enumerator.nextObject() as? DataSnapshot {
                    if let value = rest.value as? NSObject{
                        let cost = value.value(forKey: "cost") as! Double
                        let description = value.value(forKey: "description") as! String
                        let name = value.value(forKey: "name") as! String

                        let reward = Reward(named: name, withDescription: description, withCost: cost)
                        print("Reward '\(reward.name)' found.")
                        rewards.append(reward)
                    }
                }
                print("We have found \(rewards.count) rewards for event with id '\(event!.id)'.")
                completionHandler(rewards)
            }) { (error) in
                print(error.localizedDescription)
            }
        })
    }

    func getEvents(completionHandler: @escaping (_ event: [Event]) -> ()) {
        var events = [Event]()
        
        self.ref.child("events").observeSingleEvent(of: .value, with: { (snapshot) in
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? DataSnapshot {
                if let value = rest.value as? NSObject{
                    let name = value.value(forKey: "name")
                    let longitude = value.value(forKey: "longitude") as! Double
                    let latitude = value.value(forKey: "latitude") as! Double
                    let range = value.value(forKey: "range") as! Double
                    let start = value.value(forKey: "start") as! TimeInterval
                    let end = value.value(forKey: "end") as! TimeInterval
                    
                    let event = Event(withId: 1, named: name as! String, withLongitude: longitude, withLatitude: latitude , range: range, start: start, end: end)
                    events.append(event)
                }
                
            }
            completionHandler(events)
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    func getCheckedInEvent(completionHandler: @escaping (_ event: Event?) -> ()) {
        print("FirebaseService :: getCheckedInEvent()")
        var checkedInEvent: Event?
        if let uid = Auth.auth().currentUser?.uid {
            ref.child("check-ins").child("user-" + uid).child("checkin").child("event").observeSingleEvent(of: .value, with: { (snapshot) in
                if (snapshot.hasChild("id") && snapshot.hasChild("name") && snapshot.hasChild("longitude") && snapshot.hasChild("latitude") && snapshot.hasChild("range") && snapshot.hasChild("start") && snapshot.hasChild("end")) {
                    if let checkedInEventObject = snapshot.value as? NSObject {
                        print("FirebaseService :: Debug: converting to event!")
                        checkedInEvent = Event(withId: checkedInEventObject.value(forKey: "id") as! Int,
                                               named: checkedInEventObject.value(forKey: "name") as! String,
                                               withLongitude: checkedInEventObject.value(forKey: "longitude") as! Double,
                                               withLatitude: checkedInEventObject.value(forKey: "latitude") as! Double,
                                               range: checkedInEventObject.value(forKey: "range") as! Double,
                                               start: checkedInEventObject.value(forKey: "start") as! TimeInterval,
                                               end: checkedInEventObject.value(forKey: "end") as! TimeInterval)
                    }
                    completionHandler(checkedInEvent)
                } else {
                    completionHandler(nil)
                }
            }) { (error) in
                completionHandler(nil)
            }
        }
    }
    
    func getEventRecommendations(completionHandler: @escaping (_ recommendations: [Recommendation]?) -> ()) {
        var recommendations: [Recommendation] = []
        getCheckedInEvent(completionHandler: { [weak self] (event) in
            self?.ref.child("recommendations").child("event-\(event!.id)").observeSingleEvent(of: .value, with: { (snapshot) in
                let enumerator = snapshot.children
                while let rest = enumerator.nextObject() as? DataSnapshot {
                    if let value = rest.value as? NSObject {
                        if (rest.hasChild("name") && rest.hasChild("longitude") && rest.hasChild("latitude") && rest.hasChild("description") && rest.hasChild("points")) {
                            let name = value.value(forKey: "name") as! String
                            let longitude = value.value(forKey: "longitude") as! Double
                            let latitude = value.value(forKey: "latitude") as! Double
                            let description = value.value(forKey: "description") as! String
                            let points = value.value(forKey: "points") as! Int

                            let recommendation = Recommendation(withName: name, withPoint: points, withLongitude: longitude, withLatitude: latitude, withDescription: description)
                            recommendations.append(recommendation)
                        }
                    } else {
                        completionHandler(nil)
                    }
                }
                completionHandler(recommendations)
            }) { (error) in
                completionHandler(nil)
            }
        })
    }
    
    func registerCheckIn(atEvent event: Event) {
        if let userUid = Auth.auth().currentUser?.uid {
            self.ref
                .child("check-ins")
                .child("user-\(userUid)")
                .child("checkin")
                .setValue([
                    "checkin_time":  NSDate().timeIntervalSince1970,
                    "event": [
                        "end":       event.end,
                        "id":        event.id,
                        "latitude":  event.latitude,
                        "longitude": event.longitude,
                        "name":      event.name,
                        "range":     event.range,
                        "start":     event.start
                        ]
                    ])
        }
    }
}
