//
//  LaunchUITests.swift
//  Leboncoin Technical TestUITests
//
//  Created by Valentin Denis on 21/09/2021.
//

import XCTest

class LaunchUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = true
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func testLaunchIsTheFirstToBeDisplayed() {
        app.launch()
        XCTAssertTrue(app.isDisplayingLaunch)
    }
    
    func testIfLaunchIsNotShownForMoreThanThreeSeconds() {
        app.launch()
        //Check for presence of ListView after 3 seconds max
        app.otherElements["ListView"].wait(until: { $0.exists }, timeout: 3)
    }
    
}

