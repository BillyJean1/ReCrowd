//
//  ReCrowdUITests.swift
//  ReCrowdTests
//
//  Created by Ramon Schriks on 18-12-17.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import XCTest

class UILoginViewControllerTest: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testSuccessFullLogin() {
        let app = XCUIApplication()
        
        // set up an expectation predicate to test whether elements exist
        let exists = NSPredicate(format: "exists == true")
        
        // as soon as your sign in button shows up, press it
        let facebookSignInButton = app.buttons["Continue with Facebook"]
        expectation(for: exists, evaluatedWith: facebookSignInButton, handler: nil)
        self.waitForExpectations(timeout: 10, handler: nil)
        facebookSignInButton.tap()
        
        // create a reference to the button through the webView and press it
        let webView = app.descendants(matching: .webView)
        webView.buttons["Doorgaan"].tap()
        
        // validate successfull seque to new vc
        let textField = app.staticTexts.element(matching: .any, identifier: "Succesvolle inlog")
        expectation(for: exists, evaluatedWith: textField, handler: nil)
        self.waitForExpectations(timeout: 10, handler: nil)
    }
}
