//
//  DashboardViewModelDelegateMock.swift
//  CalTrackerTests
//
//  Created by Ahmed Mohiy on 27/10/2022.
//

import Foundation
import XCTest
@testable import CalTracker

class DashboardViewModelDelegateMock: NSObject, DashboardViewModelDelegate {
    
    var expectation: XCTestExpectation?
    var deleteSucceeded = false
    
    func fetchDidSucceeded() {
        expectation?.fulfill()
    }
    
    func fetchDidFailed(error: Error?) {
        expectation?.fulfill()
    }
    
    func deleteItemDidSucceded() {
        self.deleteSucceeded = true
        expectation?.fulfill()
    }
    
    func deleteItemDidFailed(error: Error?) {
        self.deleteSucceeded = false
        expectation?.fulfill()
    }
}
