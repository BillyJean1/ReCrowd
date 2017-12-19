//
//  LoginTests.swift
//  ReCrowd
//
//  Created by Colin van der Geld on 18-12-17.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import XCTest
@testable import ReCrowd

class LoginTests: XCTestCase {
    
    var firebaseService:FirebaseService!
    
    override func setUp() {
        super.setUp()
        firebaseService = FirebaseService.shared
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let event = Event(withId: -1, named: "TestEvent", withLongitude: 1.05, withLatitude: 1.50)
        firebaseService.user = User(id: "-1", name: "abc", email: "abc@nl.nl")
        firebaseService.registerCheckIn(withEvent: event)
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
