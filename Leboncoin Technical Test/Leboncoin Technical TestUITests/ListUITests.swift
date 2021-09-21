//
//  ListUITests.swift
//  Leboncoin Technical TestUITests
//
//  Created by Valentin Denis on 21/09/2021.
//

import Foundation
import XCTest

class ListUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = true
        app = XCUIApplication()
        app.launch()
    }

    func testListShowingAdsAfterFiveSeconds() {
        app.launch()
        //Assure that the user sees ads after no more than 5 seconds of launching the app
        sleep(5)
        XCTAssert(app.collectionViews.staticTexts.count > 0)
    }
    
    func testListShowingFilters() {
        app.launch()
        let annoncesNavigationBar = app.navigationBars["Annonces"]
        annoncesNavigationBar.children(matching: .button).element.tap()
        XCTAssertTrue(app.isDisplayingCategoryPicker)
    }
    
}
