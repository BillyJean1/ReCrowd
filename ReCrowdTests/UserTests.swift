//
//  UserTests.swift
//  ReCrowdTests
//
//  Created by Colin van der Geld on 03-01-18.
//  Copyright © 2018 BillyJeanOne. All rights reserved.
//

import XCTest
@testable import ReCrowd

class UserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEmptyUserInit() {
        let user = User()
        XCTAssert(user.id == nil)
        XCTAssert(user.name == nil)
        XCTAssert(user.email == nil)
    }
    
    func testUserInit() {
        let user = User(id: "1", name: "test", email: "test@test.nl")
        XCTAssert(user.id == "1")
        XCTAssert(user.name == "test")
        XCTAssert(user.email == "test@test.nl")
    }
    
    func testUserInitNillValues() {
        let user = User(id: nil, name: nil, email: nil)
    
        XCTAssert(user.id == nil)
        XCTAssert(user.name == nil)
        XCTAssert(user.email == nil)
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
