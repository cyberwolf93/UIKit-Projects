//
//  SigninViewModelDelegateMock.swift
//  CalTrackerTests
//
//  Created by Ahmed Mohiy on 27/10/2022.
//

import XCTest
@testable import CalTracker

class SigninViewModelDelegateMock: NSObject, SigninViewModelDelegate {
    
    var expectation: XCTestExpectation?
    var succedded = false
    
    func signinDidSucceeded() {
        succedded = true
        expectation?.fulfill()
    }
    
    func signinDidFailed(error: Error?) {
        succedded = false
        expectation?.fulfill()
    }
    
}
    
