//
//  CategoryTests.swift
//  Leboncoin Technical TestTests
//
//  Created by Valentin Denis on 21/09/2021.
//

import XCTest

class CategoryTests: XCTestCase {

    var sut: Category!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = Category.defaultCategory()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testCategoryDefaultHasImpossibleID() {
        //Then
        XCTAssertEqual(sut.id, -1)
    }
    
}
