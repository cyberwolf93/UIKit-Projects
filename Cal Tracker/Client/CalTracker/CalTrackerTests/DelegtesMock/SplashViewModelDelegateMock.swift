//
//  SplashViewModelDelegateMock.swift
//  CalTrackerTests
//
//  Created by Ahmed Mohiy on 27/10/2022.
//

import XCTest
@testable import CalTracker

class SplashViewModelDelegateMock: NSObject, SplashViewModelDelegate {
    
    var expectation: XCTestExpectation?
    var succedded = false
    
    func userCredentialsValid() {
        succedded = true
        expectation?.fulfill()
    }
    
    func userCredentialsNotValid() {
        succedded = false
        expectation?.fulfill()
    }
    
    
    
}
