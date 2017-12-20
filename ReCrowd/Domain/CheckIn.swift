//
//  CheckIn.swift
//  ReCrowd
//
//  Created by Kevin Broeren on 19/12/2017.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import Foundation

class CheckIn {
    public var checkInTime: Int
    public var eventId: Int
    public var userUid: String
    
    init(withCheckInTime checkInTime: Int, withEventId eventId: Int, withUserUid userUid: String) {
        self.checkInTime = checkInTime
        self.eventId = eventId
        self.userUid = userUid
    }
}
