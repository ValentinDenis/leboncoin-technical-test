//
//  AdsTests.swift
//  Leboncoin Technical TestTests
//
//  Created by Valentin Denis on 21/09/2021.
//

import XCTest

class AdsTests: XCTestCase {

    var sut: [Ad]!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = [
            Ad(id: 2, categoryId: 2, title: "Mock Title", description: "Mock Description", price: 32.5, imagesUrl: ImageUrl(small: "https://picsum.photos/200", thumb: "https://picsum.photos/200"), creationDate: "2021-09-21T16:03:37+0000", isUrgent: false),
            Ad(id: 1, categoryId: 2, title: "Mock Title", description: "Mock Description", price: 32.5, imagesUrl: ImageUrl(small: "https://picsum.photos/200", thumb: "https://picsum.photos/200"), creationDate: "2021-09-20T16:03:37+0000", isUrgent: true),
            Ad(id: 3, categoryId: 2, title: "Mock Title", description: "Mock Description", price: 32.5, imagesUrl: ImageUrl(small: "https://picsum.photos/200", thumb: "https://picsum.photos/200"), creationDate: "2021-09-23T16:03:37+0000", isUrgent: false),
            Ad(id: 5, categoryId: 2, title: "Mock Title", description: "Mock Description", price: 32.5, imagesUrl: ImageUrl(small: "https://picsum.photos/200", thumb: "https://picsum.photos/200"), creationDate: "2021-09-27T16:03:37+0000", isUrgent: true),
            Ad(id: 4, categoryId: 2, title: "Mock Title", description: "Mock Description", price: 32.5, imagesUrl: ImageUrl(small: "https://picsum.photos/200", thumb: "https://picsum.photos/200"), creationDate: "2021-09-25T16:03:37+0000", isUrgent: false),
            Ad(id: 9, categoryId: 2, title: "Mock Title", description: "Mock Description", price: 32.5, imagesUrl: ImageUrl(small: "https://picsum.photos/200", thumb: "https://picsum.photos/200"), creationDate: "2021-09-28T16:03:37+0000", isUrgent: true),
            Ad(id: 13, categoryId: 2, title: "Mock Title", description: "Mock Description", price: 32.5, imagesUrl: ImageUrl(small: "https://picsum.photos/200", thumb: "https://picsum.photos/200"), creationDate: "2021-09-22T16:03:37+0000", isUrgent: false),
            Ad(id: 23, categoryId: 2, title: "Mock Title", description: "Mock Description", price: 32.5, imagesUrl: ImageUrl(small: "https://picsum.photos/200", thumb: "https://picsum.photos/200"), creationDate: "2021-09-29T16:03:37+0000", isUrgent: true)
        ]
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testUrgentAreFirst() {
        //Given
        let sorted = Ad.sortAdsByUrgentAndDate(ads: sut)

        //Then
        XCTAssertEqual(sorted[0].isUrgent, true)
        XCTAssertEqual(sorted[1].isUrgent, true)
        XCTAssertEqual(sorted[2].isUrgent, true)
        XCTAssertEqual(sorted[3].isUrgent, true)
    }
    
    func testSortedByDate() {
        //Given
        let sorted = Ad.sortAdsByUrgentAndDate(ads: sut)
        let sortedFourth = sorted[4]
        let sortedFith = sorted[5]
        
        //Then
        XCTAssertLessThan(sortedFith, sortedFourth)
    }

}
