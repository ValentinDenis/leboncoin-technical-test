//
//  AdTests.swift
//  Leboncoin Technical TestTests
//
//  Created by Valentin Denis on 21/09/2021.
//

import XCTest

class AdTests: XCTestCase {

    var sut: Ad!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = Ad(id: 1, categoryId: 2, title: "Mock Title", description: "Mock Description", price: 32.5, imagesUrl: ImageUrl(small: "https://picsum.photos/200", thumb: "https://picsum.photos/200"), creationDate: "2021-09-21T16:03:37+0000", isUrgent: true)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testDateObjectIsCorrectFromStringDate() {
        //Given
        let dateFormat = sut.dateFormat()

        //Then
        XCTAssertEqual(dateFormat, "Mardi 21 Sept. 2021 À 06:03")
    }
    
    func testFormattedPrice() {
        //Given
        let priceFormat = sut.priceFormat()
        
        //Then
        XCTAssertEqual(priceFormat, "32,5 €")
    }
    
    func testAdsAreEquals() {
        //Given
        let adOne = Ad(id: 1, categoryId: 2, title: "", description: "", price: 0.0, imagesUrl: ImageUrl(small: "", thumb: ""), creationDate: "", isUrgent: true)
        let adTwo = Ad(id: 1, categoryId: 2, title: "", description: "", price: 0.0, imagesUrl: ImageUrl(small: "", thumb: ""), creationDate: "", isUrgent: true)
        
        //Then
        XCTAssertEqual(adOne, adTwo)
    }

}
