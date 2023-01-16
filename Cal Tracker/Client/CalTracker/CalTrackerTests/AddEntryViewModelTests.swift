//
//  AddEntryViewModelTests.swift
//  CalTrackerTests
//
//  Created by Ahmed Mohiy on 27/10/2022.
//

import XCTest
@testable import CalTracker
@testable import NetworkCore

final class AddEntryViewModelTests: XCTestCase {
    
    var foodCoreManager:FoodEntryCoreManager?
    var appPrefrences: AppPreferences?
    
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

        foodCoreManager = FoodEntryCoremanagerMock(engine: NetworkEngine(), authToken: appPrefrences!.getUserToken())
    }
    
    // Test saveFoodEntry for new entry
    func testSaveFoodEntryNewEntry() {
        let viewModel = AddEntryViewModel(foodEntryCoreManager: foodCoreManager!)
        
        let delegateMock = AddEntryViewModelDelegateMock()
        let expectation = expectation(description: "AddEntryViewModelDelegateMock")
        delegateMock.expectation = expectation
        viewModel.delegate = delegateMock
        
        viewModel.screenMode = .add
        viewModel.saveFoodEntry(foodEntry: Models.foodEntry1,
                                image: Data(),
                                oldEntry: nil)
        wait(for: [expectation], timeout: 1)
        
        XCTAssertTrue(delegateMock.addSuccedded)
    }
    
    // Test saveFoodEntry for update entry
    func testSaveFoodEntryUpdateEntry() {
        let viewModel = AddEntryViewModel(foodEntryCoreManager: foodCoreManager!)
        
        let delegateMock = AddEntryViewModelDelegateMock()
        let expectation = expectation(description: "AddEntryViewModelDelegateMock")
        delegateMock.expectation = expectation
        viewModel.delegate = delegateMock
        
        viewModel.screenMode = .edit
        viewModel.saveFoodEntry(foodEntry: Models.foodEntry1,
                                image: Data(),
                                oldEntry: Models.foodEntry1)
        wait(for: [expectation], timeout: 1)
        
        XCTAssertTrue(delegateMock.addSuccedded)
    }
    
    // Test saveFoodEntry for update entry with old entry parameter is nil
    func testSaveFoodEntryUpdateEntryWithNoUpdateEntry() {
        let viewModel = AddEntryViewModel(foodEntryCoreManager: foodCoreManager!)
        
        let delegateMock = AddEntryViewModelDelegateMock()
        let expectation = expectation(description: "AddEntryViewModelDelegateMock")
        delegateMock.expectation = expectation
        viewModel.delegate = delegateMock
        
        viewModel.screenMode = .edit
        viewModel.saveFoodEntry(foodEntry: Models.foodEntry1,
                                image: Data(),
                                oldEntry: nil)
        wait(for: [expectation], timeout: 1)
        
        XCTAssertFalse(delegateMock.addSuccedded)
    }
    
    // Test enable add date button with add only
    func testShouldEnableAddDateButtonTrue() {
        let viewModel = AddEntryViewModel(foodEntryCoreManager: foodCoreManager!)
        viewModel.screenMode = .add
        
        XCTAssertTrue(viewModel.shouldEnableAddDateButton())
    }
    
    func testShouldEnableAddDateButtonFalse() {
        let viewModel = AddEntryViewModel(foodEntryCoreManager: foodCoreManager!)
        viewModel.screenMode = .edit
        
        XCTAssertFalse(viewModel.shouldEnableAddDateButton())
    }
    
    override  func tearDown() {
        appPrefrences = nil
        foodCoreManager = nil
    }
}
