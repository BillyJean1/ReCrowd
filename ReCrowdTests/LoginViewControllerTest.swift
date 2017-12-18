//
//  LoginViewControllerTest.swift
//  ReCrowdTests
//
//  Created by Ramon Schriks on 18-12-17.
//  Copyright © 2017 BillyJeanOne. All rights reserved.
//

import XCTest
@testable import ReCrowd

class LoginViewControllerTest: XCTestCase {
    var viewController: LoginViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        viewController = storyboard.instantiateInitialViewController() as! LoginViewController
        UIApplication.shared.keyWindow!.rootViewController = viewController
        
        let _ = viewController.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoginButtonsAreDisplayed() {
        XCTAssertTrue(viewController.emailLoginButton.isEnabled)
        XCTAssertTrue(viewController.facebookLoginButton.isEnabled)
        XCTAssertNotNil(viewController.recrowdLogoImageView)
        
        var validated = false
        for subview in viewController.view.subviews {
            if subview == viewController.recrowdLogoImageView {
                validated = true
            }
        }
        XCTAssertTrue(validated)
    }
}
