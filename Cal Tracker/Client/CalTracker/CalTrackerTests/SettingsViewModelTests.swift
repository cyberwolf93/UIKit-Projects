//
//  SettingsViewModelTests.swift
//  CalTrackerTests
//
//  Created by Ahmed Mohiy on 27/10/2022.
//

import XCTest
@testable import CalTracker
@testable import NetworkCore

final class SettingsViewModelTests: XCTestCase {
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
    
    func setDataForNormalUser() {
        appPrefrences = AppPreferencesMock()
        _ = appPrefrences?.saveUser(with: SigninResponse(id: Models.user2.id,
                                                     name: Models.user2.name,
                                                     email: Models.user2.email,
                                                     token: Models.user2.token,
                                                     isAdmin: Models.user2.isAdmin,
                                                     calLimit: Models.user2.calLimit))
        userCoreManager = UserCoreManagerMock(engine: NetworkEngine(), authToken: appPrefrences!.getUserToken())
        
    }
    
    // Test update user calories limit
    func testChangeLimit() {
        let viewModel = SettingsViewModel(appPrefrencess: appPrefrences!,
                                          userCoreManager: userCoreManager!)
        
        
        let expectation = expectation(description: "testChangeLimit")
        viewModel.changeLimit(With: 200) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(appPrefrences!.getUser()!.calLimit, 200)
    }
    
    // Test prepare table view with admin
    func testPrepareTabelViewSectionForAdmin() {
        let viewModel = SettingsViewModel(appPrefrencess: appPrefrences!,
                                          userCoreManager: userCoreManager!)
        
        
        viewModel.prepareTabelViewSection()
        XCTAssertEqual(viewModel.tableViewList.count, 1)
        XCTAssertEqual(viewModel.tableViewList[0], SettingsViewModel.Cell.report)
    }
    
    // Test prepare table view with normal user
    func testPrepareTabelViewSectionForNormalUser() {
        setDataForNormalUser()
        let viewModel = SettingsViewModel(appPrefrencess: appPrefrences!,
                                          userCoreManager: userCoreManager!)
        
        
        viewModel.prepareTabelViewSection()
        XCTAssertEqual(viewModel.tableViewList.count, 1)
        XCTAssertEqual(viewModel.tableViewList[0], SettingsViewModel.Cell.calLimit)
    }
    
    
    
    
    override  func tearDown() {
        appPrefrences = nil
        userCoreManager = nil
    }
    
}

    
