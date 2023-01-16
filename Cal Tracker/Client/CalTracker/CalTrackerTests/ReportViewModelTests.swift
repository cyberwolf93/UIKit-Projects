//
//  ReportViewModelTests.swift
//  CalTrackerTests
//
//  Created by Ahmed Mohiy on 27/10/2022.
//

import XCTest
@testable import CalTracker
@testable import NetworkCore

final class ReportViewModelTests: XCTestCase {
    
    var userCoreManager:UserCoreManager?
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
        userCoreManager = UserCoreManagerMock(engine: NetworkEngine(), authToken: appPrefrences!.getUserToken())
        foodCoreManager = FoodEntryCoremanagerMock(engine: NetworkEngine(), authToken: appPrefrences!.getUserToken())
    }
    
    
    // Test range created correctly and
    // Numbers of entries for last two weeks add correctly
    // total calories last week add correctly
    func testPrepareWeekRanges() {
        let viewModel = ReportViewModel(userCoreManager: userCoreManager!,
                                        foodCoremanager: foodCoreManager!)
        
        let preTest = PreTestReportScreen()
        preTest.prepareWeekRangesForReportScreen()
        viewModel.prepareWeeksRanges()
        
        // check last week added correectly
        for (key, value) in preTest.weekEntriesDictionary[PreTestReportScreen.WeekID.lastWeek]! {
            XCTAssertEqual(viewModel.weekEntriesDictionary[ReportViewModel.WeekID.lastWeek]![key]!.date,
                           value.date)
        }
        
        // check week before added correectly
        for (key, value) in preTest.weekEntriesDictionary[PreTestReportScreen.WeekID.weekBefore]! {
            XCTAssertEqual(viewModel.weekEntriesDictionary[ReportViewModel.WeekID.weekBefore]![key]!.date,
                           value.date)
        }
        
        
        // check  lastWeekDayCaloriesDictionary
        for (key, value) in preTest.lastWeekDayCaloriesDictionary {
            XCTAssertEqual(viewModel.lastWeekDayCaloriesDictionary[key]!.date,
                           value.date)
        }
        
    }
    
    // Test prepare Report data
    func testPrepareReportData() {
        foodCoreManager = FoodEntryCoreManagerReportViewModelMock(engine: NetworkEngine(), authToken: appPrefrences!.getUserToken())
        let viewModel = ReportViewModel(userCoreManager: userCoreManager!,
                                        foodCoremanager: foodCoreManager!)
        
        let delegateMock = ReportViewModelDelegateMock()
        let expectation = expectation(description: "ReportViewModelDelegateMock")
        delegateMock.expectation = expectation
        viewModel.delegate = delegateMock
        viewModel.initViewModel()
        
        wait(for: [expectation], timeout: 1)
        
        let lastWeekDic = viewModel.weekEntriesDictionary[ReportViewModel.WeekID.lastWeek]!
    
        XCTAssertTrue(delegateMock.dataIsReady)
        XCTAssertEqual(lastWeekDic[Models.lastWeekFoodEntry4.date]!.entries.count, 1)
        
        let weekBeforeDic = viewModel.weekEntriesDictionary[ReportViewModel.WeekID.weekBefore]!
        XCTAssertEqual(weekBeforeDic[Models.weekBeforeFoodEntry5.date]!.entries.count, 1)
        
        XCTAssertNotNil(viewModel.lastWeekDayCaloriesDictionary[Models.lastWeekFoodEntry4.date])
        let laswWeekCaloriesOFDay = viewModel.lastWeekDayCaloriesDictionary[Models.lastWeekFoodEntry4.date]
        
        XCTAssertEqual(laswWeekCaloriesOFDay!.totalCalories, Models.lastWeekFoodEntry4.calValue)
        
    }
    
    // Test entry in last week range should return true
    func testInLastWeekRangeReturnTrue() {
        let viewModel = ReportViewModel(userCoreManager: userCoreManager!,
                                        foodCoremanager: foodCoreManager!)
        
        viewModel.prepareWeeksRanges()
        
        XCTAssertTrue(viewModel.inLastWeekRange(timestamp: Models.lastWeekFoodEntry4.timestamp))
    }
    
    // Test entry in last week range should return false out of range
    func testInLastWeekRangeReturnFalse() {
        let viewModel = ReportViewModel(userCoreManager: userCoreManager!,
                                        foodCoremanager: foodCoreManager!)
        
        viewModel.prepareWeeksRanges()
        
        XCTAssertFalse(viewModel.inLastWeekRange(timestamp: Models.weekBeforeFoodEntry5.timestamp))
    }
    
    // test week label for pieCHart
    func testWeekLabel() {
        foodCoreManager = FoodEntryCoreManagerReportViewModelMock(engine: NetworkEngine(), authToken: appPrefrences!.getUserToken())
        let viewModel = ReportViewModel(userCoreManager: userCoreManager!,
                                        foodCoremanager: foodCoreManager!)
        
        XCTAssertEqual(viewModel.weekLabel(by: ReportViewModel.WeekID.lastWeek),
                       "Last week")
        XCTAssertEqual(viewModel.weekLabel(by: ReportViewModel.WeekID.weekBefore),
                       "Week before")
    }
    
    
    // test PieChart return correctly
    func testGetPieChartData() {
        foodCoreManager = FoodEntryCoreManagerReportViewModelMock(engine: NetworkEngine(), authToken: appPrefrences!.getUserToken())
        let viewModel = ReportViewModel(userCoreManager: userCoreManager!,
                                        foodCoremanager: foodCoreManager!)
        let delegateMock = ReportViewModelDelegateMock()
        let expectation = expectation(description: "ReportViewModelDelegateMock")
        delegateMock.expectation = expectation
        viewModel.delegate = delegateMock
        viewModel.initViewModel()
        
        wait(for: [expectation], timeout: 1)
        
        let pieChartData = viewModel.getPieChartData()
        
        XCTAssertTrue(delegateMock.dataIsReady)
        XCTAssertNotNil(pieChartData["Last week"])
        XCTAssertNotNil(pieChartData["Week before"])
        XCTAssertEqual(pieChartData["Last week"]!, 1)
        XCTAssertEqual(pieChartData["Week before"]!, 1)
    }
    
    // test get bar chart data
    func testGetBarChartData() {
        foodCoreManager = FoodEntryCoreManagerReportViewModelMock(engine: NetworkEngine(), authToken: appPrefrences!.getUserToken())
        let viewModel = ReportViewModel(userCoreManager: userCoreManager!,
                                        foodCoremanager: foodCoreManager!)
        let delegateMock = ReportViewModelDelegateMock()
        let expectation = expectation(description: "ReportViewModelDelegateMock")
        delegateMock.expectation = expectation
        viewModel.delegate = delegateMock
        viewModel.initViewModel()
        
        wait(for: [expectation], timeout: 1)
        
        let barChartData = viewModel.getBarChartData()
        
        XCTAssertTrue(delegateMock.dataIsReady)
        XCTAssertEqual(barChartData[0][2].entries.count, 1)
        XCTAssertEqual(barChartData[1][2].entries.count, 1)
        
    }
    
    
    // test get combined chart data
    func testGetCombinedBarChart() {
        foodCoreManager = FoodEntryCoreManagerReportViewModelMock(engine: NetworkEngine(), authToken: appPrefrences!.getUserToken())
        let viewModel = ReportViewModel(userCoreManager: userCoreManager!,
                                        foodCoremanager: foodCoreManager!)
        let delegateMock = ReportViewModelDelegateMock()
        let expectation = expectation(description: "ReportViewModelDelegateMock")
        delegateMock.expectation = expectation
        viewModel.delegate = delegateMock
        viewModel.initViewModel()
        
        wait(for: [expectation], timeout: 1)
        
        let chartData = viewModel.getCombinedBarChart()
        
        XCTAssertTrue(delegateMock.dataIsReady)
        XCTAssertEqual(chartData[2].entries.count, 1)
        
    }
    
    override  func tearDown() {
        appPrefrences = nil
        userCoreManager = nil
        foodCoreManager = nil
    }
    
}
