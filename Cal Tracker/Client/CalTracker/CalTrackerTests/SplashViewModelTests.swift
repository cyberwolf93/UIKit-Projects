//
//  SplashViewModelTests.swift
//  CalTrackerTests
//
//  Created by Ahmed Mohiy on 27/10/2022.
//

import XCTest
@testable import CalTracker
@testable import NetworkCore

final class SplashViewModelTests: XCTestCase {
    var appPrefrences: AppPreferences?
    var userCoreManager:UserCoreManager?
    
    override func setUp() {
        setDataForAdminUser()
    }
    
    func setDataForAdminUser() {
        appPrefrences = AppPreferencesMock()
        _ = appPrefrences?.saveUser(with: SigninResponse(id: Models.user1.id,
                                                     name: Models.user1.name,
                                                     email: Models.user1.email,
                                                     token: Models.user1.token,
                                                     isAdmin: Models.user1.isAdmin,
                                                     calLimit: Models.user1.calLimit))
        userCoreManager = UserCoreManagerMock(engine: NetworkEngine(), authToken: appPrefrences!.getUserToken())
        
    }
    
    
    // Test user validation should succeed
    func testValidateUsershouldSucceed() {
        let viewModel = SplashViewModel(userCoreManager: userCoreManager!,
        appPrefrences: appPrefrences!)
        
        let delegateMock = SplashViewModelDelegateMock()
        let expectation = expectation(description: "SplashViewModelDelegateMock")
        delegateMock.expectation = expectation
        viewModel.delegate = delegateMock
        viewModel.validateUser()
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertTrue(delegateMock.succedded)
    }
    
    // Test user validation should fail
    func testValidateUsershouldFail() {
        appPrefrences!.deleteUserInfo()
        let viewModel = SplashViewModel(userCoreManager: userCoreManager!,
        appPrefrences: appPrefrences!)
        
        let delegateMock = SplashViewModelDelegateMock()
        let expectation = expectation(description: "SplashViewModelDelegateMock")
        delegateMock.expectation = expectation
        viewModel.delegate = delegateMock
        viewModel.validateUser()
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertFalse(delegateMock.succedded)
    }
    
    
    override  func tearDown() {
        appPrefrences = nil
        userCoreManager = nil
    }
    
}
