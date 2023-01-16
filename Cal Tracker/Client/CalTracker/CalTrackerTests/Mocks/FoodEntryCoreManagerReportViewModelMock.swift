//
//  FoodEntryCoreManagerReportViewModelMock.swift
//  CalTrackerTests
//
//  Created by Ahmed Mohiy on 27/10/2022.
//

import Foundation

@testable import NetworkCore
@testable import CalTracker

class FoodEntryCoreManagerReportViewModelMock: FoodEntryCoreManager {
    // MARK: test get all food entry for user using user id
    public override func getEntries(request: GetFoodEntriesRequest, completion: @escaping (Result<[FoodEntryResponse], Error>) -> Void ) {
        
        
        var entries: [FoodEntryResponse] = []
        entries = [FoodEntryResponse(id: Models.lastWeekFoodEntry4.id,
                                         name: Models.lastWeekFoodEntry4.name,
                                         userId: Models.user3.id,
                                         thumbUrl: Models.lastWeekFoodEntry4.thumbUrl,
                                         date: Models.lastWeekFoodEntry4.date,
                                         time: Models.lastWeekFoodEntry4.time,
                                         timestamp: Models.lastWeekFoodEntry4.timestamp,
                                         calValue: Models.lastWeekFoodEntry4.calValue),
                       
                       FoodEntryResponse(id: Models.weekBeforeFoodEntry5.id,
                                         name: Models.weekBeforeFoodEntry5.name,
                                         userId: Models.user2.id,
                                         thumbUrl: Models.weekBeforeFoodEntry5.thumbUrl,
                                         date: Models.weekBeforeFoodEntry5.date,
                                         time: Models.weekBeforeFoodEntry5.time,
                                         timestamp: Models.weekBeforeFoodEntry5.timestamp,
                                         calValue: Models.weekBeforeFoodEntry5.calValue)]
        
        completion(.success(entries))
    }
}
