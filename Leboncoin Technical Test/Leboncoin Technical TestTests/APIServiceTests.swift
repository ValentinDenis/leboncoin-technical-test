//
//  APIServiceTests.swift
//  Leboncoin Technical TestTests
//
//  Created by Valentin Denis on 21/09/2021.
//

import XCTest

class APIServiceTests: XCTestCase {

    var sut: APIService!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = APIService.shared
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testAdsAPI() {
        //Given
        let promise = expectation(description: "Completion handler invoked")

        APIService.fetchAds { result in
            switch result {
            case .success(let ads):
                XCTAssertNotNil(ads)
                XCTAssertGreaterThan(ads.count, 0)
            case .failure( _):
                XCTFail()
            }
            XCTAssertNotNil(result)
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
    }
    
    func testCategoriesAPI() {
        //Given
        let promise = expectation(description: "Completion handler invoked")

        APIService.fetchCategories { result in
            switch result {
            case .success(let categories):
                XCTAssertNotNil(categories)
                XCTAssertGreaterThan(categories.count, 0)
            case .failure( _):
                XCTFail()
            }
            XCTAssertNotNil(result)
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
    }

}
