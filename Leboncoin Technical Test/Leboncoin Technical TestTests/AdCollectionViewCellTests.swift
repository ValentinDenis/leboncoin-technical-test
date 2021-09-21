//
//  AdCollectionViewCellTests.swift
//  Leboncoin Technical TestTests
//
//  Created by Valentin Denis on 21/09/2021.
//

import XCTest

class AdCollectionViewCellTests: XCTestCase {

    var sut: AdCollectionViewCell!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = AdCollectionViewCell()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testCellIsFilledWithAdInfos() {
        //Given
        let ad = Ad(id: 1, categoryId: 2, title: "Mock Title", description: "Mock Description", price: 32.5, imagesUrl: ImageUrl(small: "https://picsum.photos/200", thumb: "https://picsum.photos/200"), creationDate: "2021-09-21T16:03:37+0000", isUrgent: true)
        let category = Category.defaultCategory()
        
        //When
        sut.fill(withAd: ad, forCategory: category)
        
        //Then
        XCTAssertEqual(sut.titleLabel.text, "Mock Title")
        XCTAssertEqual(sut.descExcerptLabel.text, "Mock Description")
        XCTAssertEqual(sut.priceLabel.text, ad.priceFormat())
    }
    
    func testCellIsCorrectlyReseted() {
        //When
        sut.prepareForReuse()
        
        //Then
        XCTAssertNil(sut.titleLabel.text)
        XCTAssertNil(sut.descExcerptLabel.text)
        XCTAssertNil(sut.adImageView.image)
        XCTAssertNil(sut.priceLabel.text)
        XCTAssertNil(sut.dateLabel.text)
        XCTAssertNil(sut.categoryLabel.text)
    }

}
