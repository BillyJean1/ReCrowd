//
//  EventTests.swift
//  ReCrowdTests
//
//  Created by Colin van der Geld on 03-01-18.
//  Copyright © 2018 BillyJeanOne. All rights reserved.
//

import XCTest
@testable import ReCrowd

class EventTests: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEventInitializer() {
        let timeInterval = Date().timeIntervalSince1970
        let event = Event(withId: -1, named: "test", withLongitude: 1.00, withLatitude: 1.2, range: 1.3, start: timeInterval, end: timeInterval)
        XCTAssert(event.id == -1)
        XCTAssert(event.name == "test")
        XCTAssert(event.longitude == 1.00)
        XCTAssert(event.latitude == 1.2)
        XCTAssert(event.range == 1.3)
        XCTAssert(event.start == timeInterval)
        XCTAssert(event.end == timeInterval)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
