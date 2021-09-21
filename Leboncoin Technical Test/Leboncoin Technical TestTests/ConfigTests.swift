//
//  ConfigTests.swift
//  Leboncoin Technical TestTests
//
//  Created by Valentin Denis on 21/09/2021.
//

import XCTest

class ConfigTests: XCTestCase {

    var sut: Config!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testEnvironmentIsCorrectlySet() {
        //Then
        XCTAssertNotNil(Config.environment)
    }
    
}
