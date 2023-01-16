//
//  AddEntryViewModelDelegate.swift
//  CalTrackerTests
//
//  Created by Ahmed Mohiy on 27/10/2022.
//

import XCTest
@testable import CalTracker

class AddEntryViewModelDelegateMock:NSObject, AddEntryViewModelDelegate {
    var expectation: XCTestExpectation?
    var addSuccedded = false
    
    func addEntryDidSucceeded() {
        addSuccedded = true
        expectation?.fulfill()
    }
    
    func addEntryDidFailed(error: Error?) {
        addSuccedded = false
        expectation?.fulfill()
    }
}
