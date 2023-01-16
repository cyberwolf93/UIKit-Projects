//
//  FoodEntryCoreManagerTests.swift
//  NetworkCoreTests
//
//  Created by Ahmed Mohiy on 28/10/2022.
//

import XCTest
@testable import NetworkCore

final class FoodEntryCoreManagerTests: XCTestCase {

  
    // test create food entries
    func testCreateFoodEntry() {
        let engine = CreateFoodEntryEngineMock()
        let req = CreateFoodEntryRequest(userId: "1",
                                         name: Models.foodEntry1["name"] as! String,
                                         date: Models.foodEntry1["date"] as! String,
                                         time: Models.foodEntry1["time"] as! String,
                                         timestamp: Models.foodEntry1["timestamp"] as! Int,
                                         calValue: Models.foodEntry1["cal_value"] as! Int)
        let expectation = expectation(description: "testCreateFoodEntry")
        var foodEntry: FoodEntryResponse?
        FoodEntryCoreManager(engine: engine, authToken: "").createFoodEntry(request: req) { result in
            switch(result) {
            case .success(let entry):
                foodEntry = entry
                expectation.fulfill()
            case .failure(_ ):
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertNotNil(foodEntry)
        XCTAssertEqual(foodEntry!.name, Models.foodEntry1["name"] as! String)
    }
    
    // test Update food entries success
    func testUpdateFoodEntrySuccess() {
        let engine = UpdateFoodEntryEngineMock()
        let req = UpdateFoodEntryRequest(entryId: Models.foodEntry1["id"] as! String,
                                         userId: "1",
                                         name: Models.foodEntry1["name"] as! String,
                                         calValue: Models.foodEntry1["cal_value"] as! Int)
        let expectation = expectation(description: "testUpdateFoodEntrySuccess")
        var foodEntry: FoodEntryResponse?
        FoodEntryCoreManager(engine: engine, authToken: "1313").updateFoodEntry(request: req) { result in
            switch(result) {
            case .success(let entry):
                foodEntry = entry
                expectation.fulfill()
            case .failure(_ ):
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertNotNil(foodEntry)
        XCTAssertEqual(foodEntry!.name, Models.foodEntry1["name"] as! String)
    }
    
    // test Update food entries failure
    func testUpdateFoodEntryFailure() {
        let engine = UpdateUserCaloriesLimitEngineMock()
        let req = UpdateFoodEntryRequest(entryId: Models.foodEntry1["id"] as! String,
                                         userId: "1",
                                         name: Models.foodEntry1["name"] as! String,
                                         calValue: Models.foodEntry1["cal_value"] as! Int)
        let expectation = expectation(description: "testUpdateFoodEntryFailure")
        var foodEntry: FoodEntryResponse?
        FoodEntryCoreManager(engine: engine, authToken: "").updateFoodEntry(request: req) { result in
            switch(result) {
            case .success(let entry):
                foodEntry = entry
                expectation.fulfill()
            case .failure(_ ):
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertNil(foodEntry)
       
    }
    
    // test DELETE food entries SUCCESS
    func testDeleteFoodEntrySuccess() {
        let engine = DeleteFoodEntryEngineMock()
        let req = DeleteFoodEntryRequest(entryId: Models.foodEntry1["id"] as! String,
                                         userId: "1")
        let expectation = expectation(description: "testDeleteFoodEntrySuccess")
        var succeeded = false
        FoodEntryCoreManager(engine: engine, authToken: "asdas").deleteFoodEntry(request: req) { result in
            switch(result) {
            case .success(_ ):
                succeeded = true
                expectation.fulfill()
            case .failure(_ ):
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertTrue(succeeded)
       
    }

    // test DELETE food entries failure
    func testDeleteFoodEntryFailure() {
        let engine = DeleteFoodEntryEngineMock()
        let req = DeleteFoodEntryRequest(entryId: Models.foodEntry1["id"] as! String,
                                         userId: "1")
        let expectation = expectation(description: "testDeleteFoodEntrySuccess")
        var succeeded = false
        FoodEntryCoreManager(engine: engine, authToken: "").deleteFoodEntry(request: req) { result in
            switch(result) {
            case .success(_ ):
                succeeded = true
                expectation.fulfill()
            case .failure(_ ):
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertFalse(succeeded)
       
    }
    
    // test get all food entries
    func testGetEntries() {
        let engine = GetFoodEntriesEngineMock()
        let req = GetFoodEntriesRequest(userId: "1")
        let expectation = expectation(description: "testGetEntries")
        var foodEntries:[FoodEntryResponse] = []
        FoodEntryCoreManager(engine: engine, authToken: "").getEntries(request: req) { result in
            switch(result) {
            case .success(let entries):
                foodEntries = entries
                expectation.fulfill()
            case .failure(_ ):
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(foodEntries.count, 2)
       
    }

}
