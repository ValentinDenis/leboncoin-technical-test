//
//  CategoryPickerViewControllerTests.swift
//  Leboncoin Technical TestTests
//
//  Created by Valentin Denis on 21/09/2021.
//

import XCTest
@testable import DEV

class CategoryPickerViewControllerTests: XCTestCase {

    var sut: CategoryPickerViewController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = DEV.CategoryPickerViewController()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testDatasourceIsCorrectlyEmptyAtInit() {
        //Then
        XCTAssertNotNil(sut.categoryDataSource)
        XCTAssertEqual(sut.categoryDataSource.count, 0)
    }
    
    func testTitleIsCorrectlySetWhenInitialized() {
        //When
        sut.initialize()
        
        //Then
        XCTAssertEqual(sut.title, "Filtres")
    }
    
    func testTableViewIsCorrectlyPresented() {
        //When
        sut.initialize()
        
        //Then
        XCTAssertTrue(sut.view.subviews.contains(sut.tableView))
    }
}
