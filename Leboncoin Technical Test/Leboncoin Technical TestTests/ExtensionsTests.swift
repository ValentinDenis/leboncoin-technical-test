//
//  ExtensionsTests.swift
//  Leboncoin Technical TestTests
//
//  Created by Valentin Denis on 21/09/2021.
//

import XCTest

class ExtensionsTests: XCTestCase {

    var sut: UIImageView!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = UIImageView()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testImageIsDefaultWhenUrlIsBad() {
        //Given
        let promise = expectation(description: "Completion handler invoked")

        sut.load(url: URL(string: "https://google.fr")!) {[weak self] in
            guard let self = self else { return }
            XCTAssertNotNil(self.sut.image)
            XCTAssertEqual(self.sut.image, UIImage(named: "placeholder"))
            promise.fulfill()
        }

        wait(for: [promise], timeout: 5)
    }
    
    func testImageCorrectIfUrlIsGood() {
        //Given
        let promise = expectation(description: "Completion handler invoked")

        sut.load(url: URL(string: "https://picsum.photos/200")!) {[weak self] in
            guard let self = self else { return }
            XCTAssertNotNil(self.sut.image)
            XCTAssertNotEqual(self.sut.image, UIImage(named: "placeholder"))
            promise.fulfill()
        }

        wait(for: [promise], timeout: 5)
    }
}
