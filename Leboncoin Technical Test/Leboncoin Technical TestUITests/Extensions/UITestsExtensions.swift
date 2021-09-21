//
//  UITestsExtensions.swift
//  Leboncoin Technical TestUITests
//
//  Created by Valentin Denis on 21/09/2021.
//

import XCTest

extension XCUIApplication {
    var isDisplayingLaunch: Bool {
        return otherElements["LaunchView"].exists
    }
    
    var isDisplayingList: Bool {
        return otherElements["ListView"].exists
    }
    
    var isDisplayingCategoryPicker: Bool {
        return otherElements["CategoryPickerView"].exists
    }
    
    var isDisplayingDetail: Bool {
        return otherElements["DetailView"].exists
    }
}

extension XCUIElement {
    @discardableResult
    func wait(until expression: @escaping (XCUIElement) -> Bool, timeout: TimeInterval = 15, message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) -> Self {
        if expression(self) {
            return self
        }

        let predicate = NSPredicate { _, _ in
            expression(self)
        }

        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: nil)

        let result = XCTWaiter().wait(for: [expectation], timeout: timeout)

        if result != .completed {
            XCTFail(message().isEmpty ? "expectation not matched after waiting" : message(), file: file, line: line)
        }

        return self
    }
}
