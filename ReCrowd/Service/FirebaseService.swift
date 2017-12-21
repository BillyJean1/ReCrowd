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
        recommendations.append(Recommendation(withName: "Python", withPoint: 200, withLongitude: 5.0517359, withLatitude: 51.6485471, withDescription: "De python is een achtbaan voor echte thrill-seekers"))
        recommendations.append(Recommendation(withName: "Joris en de Draak", withPoint: 200, withLongitude: 5.0515974, withLatitude: 51.646975, withDescription: "Joris en de Draak is een achtbaan voor echte thrill-seekers"))
        recommendations.append(Recommendation(withName: "Fata Morgana", withPoint: 200, withLongitude: 5.0450622, withLatitude: 51.6470669, withDescription: "De Fata Morgana is een waterattractie voor echte theme-lovers"))
        recommendations.append(Recommendation(withName: "Piranha", withPoint: 200, withLongitude: 5.0489554, withLatitude: 51.6472064, withDescription: "De Piranha is een waterattractie voor echte thrill-lovers"))
        recommendations.append(Recommendation(withName: "Bobslee", withPoint: 200, withLongitude: 5.046126, withLatitude: 51.6470839, withDescription: "De Bobslee is een slee-attractie voor echte thrill-lovers"))
        
        var completed: [Recommendation] = []
        var random = Int(arc4random_uniform(UInt32(recommendations.count)))
        completed.append(recommendations[random])
        recommendations.remove(at: random)
        
        random = Int(arc4random_uniform(UInt32(recommendations.count)))
        completed.append(recommendations[random])
        recommendations.remove(at: random)
        
        random = Int(arc4random_uniform(UInt32(recommendations.count)))
        completed.append(recommendations[random])
        recommendations.remove(at: random)
    

        completionHandler(completed)
        

//        print("FirebaseService :: checkForRecommendations()")
//        FirebaseService.shared.getCheckedInEvent(completionHandler: { event in
//
//        })
    }
    
    func registerCheckIn(withEvent eventInRange: Event) {
        self.ref.child("events").child("\(eventInRange.id)").setValue(["name":eventInRange.name, "longitude":eventInRange.longitude, "latitude":eventInRange.latitude])
        
        self.ref.child("checkIns").setValue(["uid":user?.id!,"event_id":eventInRange.id])
        self.ref.child("check-ins").setValue(["uid":user?.id!,"event_id":eventInRange.id])
        // Firebase stuff (tududu du du duu (tudu du du du duu)
    }
    
    // * This code can be used to create an event * //
    //    func createEvent(){
    //        self.ref.child("events").child("\(eventInRange.id)").setValue(["name":eventInRange.name, "longitude":eventInRange.longitude, "latitude":eventInRange.latitude, "range":eventInRange.range, "start":Int(eventInRange.start), "end":Int(eventInRange.end)])
    //    }
    
}
