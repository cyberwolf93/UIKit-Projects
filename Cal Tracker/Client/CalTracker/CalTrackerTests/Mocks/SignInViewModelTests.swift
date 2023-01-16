//
//  SignInViewModelTests.swift
//  CalTrackerTests
//
//  Created by Ahmed Mohiy on 27/10/2022.
//

import XCTest
@testable import CalTracker
@testable import NetworkCore

final class SignInViewModelTests: XCTestCase {
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
    
    // Test sign in
    func testSignIn() {
        let viewModel = SigninViewModel(userCoreManager: userCoreManager!,
                                        appPrefrences: appPrefrences!)
        
        let delegateMock = SigninViewModelDelegateMock()
        let expectation = expectation(description: "SigninViewModelDelegateMock")
        delegateMock.expectation = expectation
        viewModel.delegate = delegateMock
        viewModel.signin(email: Models.user1.email,
                         password: "12345678")
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertTrue(delegateMock.succedded)
        XCTAssertNotNil(appPrefrences!.getUser())
        XCTAssertEqual(appPrefrences!.getUser()?.email, Models.user1.email)
    }
    
    
    
    override  func tearDown() {
        appPrefrences = nil
        userCoreManager = nil
    }
    
}
