//
//  CategoryTableViewCellTests.swift
//  Leboncoin Technical TestTests
//
//  Created by Valentin Denis on 21/09/2021.
//

import XCTest
@testable import DEV

class CategoryTableViewCellTests: XCTestCase {

    var sut: CategoryTableViewCell!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CategoryTableViewCell()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testCellIsFilledWithCategoryInfos() {
        //Given
        let category = DEV.Category(id: 1, name: "Test")
        
        //When
        sut.fill(withCategory: category, selected: true)
        
        //Then
        XCTAssertEqual(sut.nameLabel.text, "Test")
        XCTAssertEqual(sut.selectedImageView.isHidden, false)
    }
    
    func testCellIsCorrectlyReseted() {
        //When
        sut.prepareForReuse()
        
        //Then
        XCTAssertNil(sut.nameLabel.text)
    }

}
