//
//  ReportViewModelDelegateMock.swift
//  CalTrackerTests
//
//  Created by Ahmed Mohiy on 27/10/2022.
//

import XCTest
@testable import CalTracker

class ReportViewModelDelegateMock:NSObject, ReportViewModelDelegate {
    
    var expectation: XCTestExpectation?
    var dataIsReady = false
    
    func reportDataIsReady() {
        dataIsReady = true
        expectation?.fulfill()
    }
    
    func failedToPrepareReportData() {
        dataIsReady = false
        expectation?.fulfill()
    }
    
}
