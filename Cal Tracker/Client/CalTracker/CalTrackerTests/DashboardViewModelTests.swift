//
//  CalTrackerTests.swift
//  CalTrackerTests
//
//  Created by Ahmed Mohiy on 22/10/2022.
//

import XCTest
@testable import CalTracker
@testable import NetworkCore

final class DashboardViewModelTests: XCTestCase {
    
    var userCoreManager:UserCoreManager?
    var foodCoreManager:FoodEntryCoreManager?
    var appPrefrences: AppPreferences?

    override func setUp() {
        setDataForAdminUser()
    }
    
    func setDataForNormalUserWithTodaysEntry() {
        appPrefrences = AppPreferencesMock()
        _ = appPrefrences?.saveUser(with: SigninResponse(id: Models.user3.id,
                                                     name: Models.user3.name,
                                                     email: Models.user3.email,
                                                     token: Models.user3.token,
                                                     isAdmin: Models.user3.isAdmin,
                                                     calLimit: Models.user3.calLimit))
        userCoreManager = UserCoreManagerMock(engine: NetworkEngine(), authToken: appPrefrences!.getUserToken())
        foodCoreManager = FoodEntryCoremanagerMock(engine: NetworkEngine(), authToken: appPrefrences!.getUserToken())
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
        foodCoreManager = FoodEntryCoremanagerMock(engine: NetworkEngine(), authToken: appPrefrences!.getUserToken())
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
        foodCoreManager = FoodEntryCoremanagerMock(engine: NetworkEngine(), authToken: appPrefrences!.getUserToken())
    }
    
    func getFoodEntryWithEmptyId() -> FoodEntry{
        return FoodEntry(id: "",
                         name: "",
                         userId: "",
                         thumbUrl: "",
                         date: "",
                         time: "",
                         timestamp: 0,
                         calValue: 0)
    }
    
    
    
    
    func testFetchAllEntriesForAdmin() {
        let viewModel = DashboardViewModel(foodEntryCoreManager: foodCoreManager!,
                                           userCoreManager: userCoreManager!,
                                           appPrefrences: appPrefrences!)
        
        let delegateMock = DashboardViewModelDelegateMock()
        let expectation = expectation(description: "DashboardViewModelDelegateMock")
        delegateMock.expectation = expectation
        viewModel.delegate = delegateMock
        viewModel.fetchAllEntries()
        
        wait(for: [expectation], timeout: 1)
        
        print(viewModel.getFilterdFoodEntries())
        XCTAssert(viewModel.getFilterdFoodEntries().count == 3)
        
    }
    
    func testFetchAllEntriesForNormalUser() {
        setDataForNormalUser()
        let viewModel = DashboardViewModel(foodEntryCoreManager: foodCoreManager!,
                                           userCoreManager: userCoreManager!,
                                           appPrefrences: appPrefrences!)
        
        let delegateMock = DashboardViewModelDelegateMock()
        let expectation = expectation(description: "DashboardViewModelDelegateMock")
        delegateMock.expectation = expectation
        viewModel.delegate = delegateMock
        viewModel.fetchAllEntries()
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssert(viewModel.getFilterdFoodEntries().count == 2)
        
    }
    
    // This function test if all user will be fetched if the user is admin after
    // Fetching all entries
    func testFetchAllUserAdminRole() {
        let viewModel = DashboardViewModel(foodEntryCoreManager: foodCoreManager!,
                                           userCoreManager: userCoreManager!,
                                           appPrefrences: appPrefrences!)
        
        let delegateMock = DashboardViewModelDelegateMock()
        let expectation = expectation(description: "DashboardViewModelDelegateMock")
        delegateMock.expectation = expectation
        viewModel.delegate = delegateMock
        viewModel.fetchAllEntries()
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssert(viewModel.getAllUsers().count > 0)
    }
    
    // This function test if all user will not be fetched if the user is normal after
    // Fetching all entries
    func testFetchAllUserNormalRole() {
        setDataForNormalUser()
        let viewModel = DashboardViewModel(foodEntryCoreManager: foodCoreManager!,
                                           userCoreManager: userCoreManager!,
                                           appPrefrences: appPrefrences!)
        
        let delegateMock = DashboardViewModelDelegateMock()
        let expectation = expectation(description: "DashboardViewModelDelegateMock")
        delegateMock.expectation = expectation
        viewModel.delegate = delegateMock
        viewModel.fetchAllEntries()
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssert(viewModel.getAllUsers().count == 0)
    }
    
    // test delete Entry
    func testDeleteEntryShouldSucceed() {
        let viewModel = DashboardViewModel(foodEntryCoreManager: foodCoreManager!,
                                           userCoreManager: userCoreManager!,
                                           appPrefrences: appPrefrences!)
        
        let delegateMock = DashboardViewModelDelegateMock()
        let expectation = expectation(description: "DashboardViewModelDelegateMock")
        delegateMock.expectation = expectation
        viewModel.delegate = delegateMock
        viewModel.deleteFoodEntry(with: Models.foodEntry1)
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertTrue(delegateMock.deleteSucceeded)
    }
    
    func testDeleteEntryShouldFail() {
        let viewModel = DashboardViewModel(foodEntryCoreManager: foodCoreManager!,
                                           userCoreManager: userCoreManager!,
                                           appPrefrences: appPrefrences!)
        
        let delegateMock = DashboardViewModelDelegateMock()
        let expectation = expectation(description: "DashboardViewModelDelegateMock")
        delegateMock.expectation = expectation
        viewModel.delegate = delegateMock
        viewModel.deleteFoodEntry(with: getFoodEntryWithEmptyId())
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertFalse(delegateMock.deleteSucceeded)
    }
    
    // test get total number of calories from today's each food entries
    func testNumberOfCaloriesOfToday() {
        setDataForNormalUserWithTodaysEntry()
        let viewModel = DashboardViewModel(foodEntryCoreManager: foodCoreManager!,
                                           userCoreManager: userCoreManager!,
                                           appPrefrences: appPrefrences!)
        
        let delegateMock = DashboardViewModelDelegateMock()
        let expectation = expectation(description: "DashboardViewModelDelegateMock")
        delegateMock.expectation = expectation
        viewModel.delegate = delegateMock
        viewModel.fetchAllEntries()
        wait(for: [expectation], timeout: 1)
        
        
        XCTAssertEqual(viewModel.numberOfCaloriesOfToday(), Models.todayFoodEntry3.calValue)
    }
    
    // test get total number of calories from today's each food entries
    // this should return 0  because there is entries today
    func testNumberOfCaloriesOfTodayWithZeroEntries() {
        setDataForNormalUser()
        foodCoreManager = FoodEntryCoreMangerWithNoEntriesForToday(engine: NetworkEngine(),
                                                                   authToken: appPrefrences!.getUserToken())
        let viewModel = DashboardViewModel(foodEntryCoreManager: foodCoreManager!,
                                           userCoreManager: userCoreManager!,
                                           appPrefrences: appPrefrences!)
        
        let delegateMock = DashboardViewModelDelegateMock()
        let expectation = expectation(description: "DashboardViewModelDelegateMock")
        delegateMock.expectation = expectation
        viewModel.delegate = delegateMock
        viewModel.fetchAllEntries()
        wait(for: [expectation], timeout: 1)
        
        
        XCTAssertEqual(viewModel.numberOfCaloriesOfToday(), 0)
    }
    
    // Test get user limit
    func testGetUserCaloriesLimit() {
        let viewModel = DashboardViewModel(foodEntryCoreManager: foodCoreManager!,
                                           userCoreManager: userCoreManager!,
                                           appPrefrences: appPrefrences!)
        let limit = viewModel.getCaloriesLimit()
        XCTAssertEqual(limit, Models.user1.calLimit)
    }
    
    // Test get user limit
    func testGetUserCaloriesLimitWithNoUser() {
        appPrefrences?.deleteUserInfo()
        let viewModel = DashboardViewModel(foodEntryCoreManager: foodCoreManager!,
                                           userCoreManager: userCoreManager!,
                                           appPrefrences: appPrefrences!)
        let limit = viewModel.getCaloriesLimit()
        XCTAssertEqual(limit, 0)
    }
    
    // test check if user admin with admin user
    func testUserIsAdminWithAdminUser() {
        let viewModel = DashboardViewModel(foodEntryCoreManager: foodCoreManager!,
                                           userCoreManager: userCoreManager!,
                                           appPrefrences: appPrefrences!)
        
        XCTAssertTrue(viewModel.userIsAdmin())
    }
    
    // test check if user admin with normal user
    func testUserIsAdminWithNormalUser() {
        setDataForNormalUser()
        let viewModel = DashboardViewModel(foodEntryCoreManager: foodCoreManager!,
                                           userCoreManager: userCoreManager!,
                                           appPrefrences: appPrefrences!)
        
        XCTAssertFalse(viewModel.userIsAdmin())
    }
    
    // Test get normal user
    func testGetNormalUser() {
        setDataForNormalUser()
        let viewModel = DashboardViewModel(foodEntryCoreManager: foodCoreManager!,
                                           userCoreManager: userCoreManager!,
                                           appPrefrences: appPrefrences!)
        let user = viewModel.getUserIfNormal()
        XCTAssertNotNil(user)
    }
    
    // Test get normal user and current user is admin
    func testGetNormalUserWithAdminUser() {
        let viewModel = DashboardViewModel(foodEntryCoreManager: foodCoreManager!,
                                           userCoreManager: userCoreManager!,
                                           appPrefrences: appPrefrences!)
        let user = viewModel.getUserIfNormal()
        XCTAssertNil(user)
    }
    
    // Get selected user for filteration user users
    func testUserIsSelectedForFilterByUser() {
        let viewModel = DashboardViewModel(foodEntryCoreManager: foodCoreManager!,
                                           userCoreManager: userCoreManager!,
                                           appPrefrences: appPrefrences!)
        viewModel.setSelectedUser(user: Models.user2)
        
        XCTAssertNotNil(viewModel.getSelectedUser())
    }
    
    
    // Test filter date is on
    func testFilterDateIsOn() {
        let viewModel = DashboardViewModel(foodEntryCoreManager: foodCoreManager!,
                                           userCoreManager: userCoreManager!,
                                           appPrefrences: appPrefrences!)
        
        viewModel.setFilterDateFrom("12-10-2022")
        viewModel.setFilterDateTo("12-10-2022")
        
        XCTAssertTrue(viewModel.isFilterDateOn())
    }
    
    // Test failure of filter date is on
    // by set the date from only and keep date to empty
    func testFilterDateIsOnWithDateFromOnly() {
        let viewModel = DashboardViewModel(foodEntryCoreManager: foodCoreManager!,
                                           userCoreManager: userCoreManager!,
                                           appPrefrences: appPrefrences!)
        
        viewModel.setFilterDateFrom("12-10-2022")
        
        XCTAssertFalse(viewModel.isFilterDateOn())
    }
    
    // Test user filter is on
    func testUserFilterIsOn() {
        let viewModel = DashboardViewModel(foodEntryCoreManager: foodCoreManager!,
                                           userCoreManager: userCoreManager!,
                                           appPrefrences: appPrefrences!)
        
        viewModel.setSelectedUser(user: Models.user2)
        
        XCTAssertTrue(viewModel.isFilterUserOn())
    }
    
    // Test user filter is on
    // by not selecting a user and it should return false
    func testUserFilterIsOnWithEptySelectedUser() {
        let viewModel = DashboardViewModel(foodEntryCoreManager: foodCoreManager!,
                                           userCoreManager: userCoreManager!,
                                           appPrefrences: appPrefrences!)
        
        
        XCTAssertFalse(viewModel.isFilterUserOn())
    }
    
    // Test get sorted food list ascending
    func testGetFoodSortedList() {
        foodCoreManager = FoodEntryCoreMangerWithNoEntriesForToday(engine: NetworkEngine(),
                                                                   authToken: appPrefrences!.getUserToken())
        let viewModel = DashboardViewModel(foodEntryCoreManager: foodCoreManager!,
                                           userCoreManager: userCoreManager!,
                                           appPrefrences: appPrefrences!)
        
        let delegateMock = DashboardViewModelDelegateMock()
        let expectation = expectation(description: "DashboardViewModelDelegateMock")
        delegateMock.expectation = expectation
        viewModel.delegate = delegateMock
        viewModel.fetchAllEntries()
        wait(for: [expectation], timeout: 1)
        
        let sortedList = viewModel.getFoodSortedList()
        XCTAssertEqual(sortedList[0].id, Models.foodEntry2.id)
        XCTAssertEqual(sortedList[1].id, Models.foodEntry1.id)
    }
    
    // Test get all user sorted food list ascending
    func testGetSelectedUserFoodEntriesList() {
        setDataForNormalUser()
        foodCoreManager = FoodEntryCoreMangerWithNoEntriesForToday(engine: NetworkEngine(),
                                                                   authToken: appPrefrences!.getUserToken())
        let viewModel = DashboardViewModel(foodEntryCoreManager: foodCoreManager!,
                                           userCoreManager: userCoreManager!,
                                           appPrefrences: appPrefrences!)
        
        let delegateMock = DashboardViewModelDelegateMock()
        let expectation = expectation(description: "DashboardViewModelDelegateMock")
        delegateMock.expectation = expectation
        viewModel.delegate = delegateMock
        viewModel.fetchAllEntries()
        wait(for: [expectation], timeout: 1)
        
        viewModel.setSelectedUser(user: Models.user2)
        let userSortedList = viewModel.getSelectedUserList()
        print(userSortedList[0])
        XCTAssertEqual(userSortedList[0].id, Models.foodEntry2.id)
        XCTAssertEqual(userSortedList[1].id, Models.foodEntry1.id)
    }
    
    //Test reset user Filter
    func testResetUserFilter() {
        let viewModel = DashboardViewModel(foodEntryCoreManager: foodCoreManager!,
                                           userCoreManager: userCoreManager!,
                                           appPrefrences: appPrefrences!)
        viewModel.setSelectedUser(user: Models.user2)
        viewModel.resetUserFilter()
        XCTAssertNil(viewModel.getSelectedUser())
    }
    
    // Test reset date filter
    func testResetDateFilter() {
        let viewModel = DashboardViewModel(foodEntryCoreManager: foodCoreManager!,
                                           userCoreManager: userCoreManager!,
                                           appPrefrences: appPrefrences!)
        
        viewModel.setFilterDateFrom("12-10-2022")
        viewModel.setFilterDateTo("12-10-2022")
        viewModel.resetDateFilter()
        XCTAssertFalse(viewModel.isFilterDateOn())
    }
    
    // Test check food Entries timestamp in the range
    // of the filtered dates
    func testCheckFoodEntryInRange() {
        let viewModel = DashboardViewModel(foodEntryCoreManager: foodCoreManager!,
                                           userCoreManager: userCoreManager!,
                                           appPrefrences: appPrefrences!)
        let timestamp = 1665596791
        viewModel.setFilterDateFrom("11-10-2022")
        viewModel.setFilterDateTo("13-10-2022")
        XCTAssertTrue(viewModel.checkFoodEntryInRange(timeStamp: timestamp))
    }
    
    // Test check food Entries timestamp out of  the range
    // of the filtered dates
    func testCheckFoodEntryOutOfRange() {
        let viewModel = DashboardViewModel(foodEntryCoreManager: foodCoreManager!,
                                           userCoreManager: userCoreManager!,
                                           appPrefrences: appPrefrences!)
        let timestamp = 1665596791
        viewModel.setFilterDateFrom("13-10-2022")
        viewModel.setFilterDateTo("13-10-2022")
        XCTAssertFalse(viewModel.checkFoodEntryInRange(timeStamp: timestamp))
    }
    
    // Test check food Entries timestamp and there is no range the filter is off
    // of the filtered dates this should return true
    func testCheckFoodEntryNoRange() {
        let viewModel = DashboardViewModel(foodEntryCoreManager: foodCoreManager!,
                                           userCoreManager: userCoreManager!,
                                           appPrefrences: appPrefrences!)
        let timestamp = 1665596791
        XCTAssertTrue(viewModel.checkFoodEntryInRange(timeStamp: timestamp))
    }
    
    // Test date filter range is correct
    func testGetFilterDateRange() {
        let viewModel = DashboardViewModel(foodEntryCoreManager: foodCoreManager!,
                                           userCoreManager: userCoreManager!,
                                           appPrefrences: appPrefrences!)
        let dateFrom = Date().addingTimeInterval(1665596791)
        let dateTo = Date().addingTimeInterval(1665683191)
        viewModel.setFilterDateFrom("12-10-2022")
        viewModel.setFilterDateTo("13-10-2022")
        let dateFilter = viewModel.getFilterDateRange()
        print(Date.stringFromDate(date: Date().addingTimeInterval(TimeInterval(dateFilter.0)), formate: "dd-MM-yyyy"))
        XCTAssertEqual(Date.stringFromDate(date: Date(timeIntervalSince1970: TimeInterval(dateFilter.0)),
                                           formate: "dd-MM-yyyy"),
                       "12-10-2022")
        
        XCTAssertEqual(Date.stringFromDate(date: Date(timeIntervalSince1970: TimeInterval(dateFilter.1)),
                                           formate: "dd-MM-yyyy"),
                       "13-10-2022")
    }
    
    // Test apply filter to fetched food entries
    // should return food entries for user2 and in the date range
    func testApplyFilterWithDateAndUser() {
        let viewModel = DashboardViewModel(foodEntryCoreManager: foodCoreManager!,
                                           userCoreManager: userCoreManager!,
                                           appPrefrences: appPrefrences!)
        
        let delegateMock = DashboardViewModelDelegateMock()
        let expectation = expectation(description: "DashboardViewModelDelegateMock")
        delegateMock.expectation = expectation
        viewModel.delegate = delegateMock
        
        viewModel.setSelectedUser(user: Models.user2)
        viewModel.setFilterDateFrom("11-10-2022")
        viewModel.setFilterDateTo("13-10-2022")
        viewModel.fetchAllEntries()
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(viewModel.getFilterdFoodEntries().count, 1)
    }
    
    // Test apply filter to fetched food entries
    // should return food entries for user2
    func testApplyFilterWithUser() {
        let viewModel = DashboardViewModel(foodEntryCoreManager: foodCoreManager!,
                                           userCoreManager: userCoreManager!,
                                           appPrefrences: appPrefrences!)
        
        let delegateMock = DashboardViewModelDelegateMock()
        let expectation = expectation(description: "DashboardViewModelDelegateMock")
        delegateMock.expectation = expectation
        viewModel.delegate = delegateMock
        
        viewModel.setSelectedUser(user: Models.user2)
        viewModel.fetchAllEntries()
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(viewModel.getFilterdFoodEntries().count, 2)
    }
    
    // Test apply filter to fetched food entries
    // should return food entries with date in range
    func testApplyFilterWithDateInRange() {
        let viewModel = DashboardViewModel(foodEntryCoreManager: foodCoreManager!,
                                           userCoreManager: userCoreManager!,
                                           appPrefrences: appPrefrences!)
        
        let delegateMock = DashboardViewModelDelegateMock()
        let expectation = expectation(description: "DashboardViewModelDelegateMock")
        delegateMock.expectation = expectation
        viewModel.delegate = delegateMock
        
        viewModel.setFilterDateFrom("11-10-2022")
        viewModel.setFilterDateTo("13-10-2022")
        viewModel.fetchAllEntries()
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(viewModel.getFilterdFoodEntries().count, 1)
    }
    
    // Tets get Coolection View title with filter date on
    func testGetCollectionViewTitleWithFilterOn() {
        let viewModel = DashboardViewModel(foodEntryCoreManager: foodCoreManager!,
                                           userCoreManager: userCoreManager!,
                                           appPrefrences: appPrefrences!)
        viewModel.setFilterDateFrom("11-10-2022")
        viewModel.setFilterDateTo("13-10-2022")
        XCTAssertEqual(viewModel.getCollectionViewTitle(), "11-10-2022 to 13-10-2022")
    }
    
    //
    // Tets get Coolection View title with no filter
    func testGetCollectionViewTitleWithNoFilter() {
        let viewModel = DashboardViewModel(foodEntryCoreManager: foodCoreManager!,
                                           userCoreManager: userCoreManager!,
                                           appPrefrences: appPrefrences!)
        XCTAssertEqual(viewModel.getCollectionViewTitle(), "All Food Entries")
    }
    
    
    
    
    
    override  func tearDown() {
        appPrefrences = nil
        userCoreManager = nil
        foodCoreManager = nil
    }
    
}
