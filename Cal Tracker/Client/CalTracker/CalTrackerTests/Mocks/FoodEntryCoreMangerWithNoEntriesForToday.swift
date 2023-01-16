//
//  FoodEntryCoreMangerWithNoEntriesForToday.swift
//  CalTrackerTests
//
//  Created by Ahmed Mohiy on 27/10/2022.
//

import Foundation
@testable import NetworkCore
@testable import CalTracker

class FoodEntryCoreMangerWithNoEntriesForToday: FoodEntryCoreManager {
    
    // MARK: test get all food entry for user using user id
    public override func getEntries(request: GetFoodEntriesRequest, completion: @escaping (Result<[FoodEntryResponse], Error>) -> Void ) {
        
        
        var entries: [FoodEntryResponse] = []
        if request.userId.isEmpty {
            entries = [FoodEntryResponse(id: Models.foodEntry1.id,
                                             name: Models.foodEntry1.name,
                                             userId: Models.user2.id,
                                             thumbUrl: Models.foodEntry1.thumbUrl,
                                             date: Models.foodEntry1.date,
                                             time: Models.foodEntry1.time,
                                             timestamp: Models.foodEntry1.timestamp,
                                             calValue: Models.foodEntry1.calValue),
                           
                           FoodEntryResponse(id: Models.foodEntry2.id,
                                             name: Models.foodEntry2.name,
                                             userId: Models.user2.id,
                                             thumbUrl: Models.foodEntry2.thumbUrl,
                                             date: Models.foodEntry2.date,
                                             time: Models.foodEntry2.time,
                                             timestamp: Models.foodEntry2.timestamp,
                                             calValue: Models.foodEntry2.calValue)]
            
        } else if request.userId == Models.user2.id {
            entries = [FoodEntryResponse(id: Models.foodEntry2.id,
                                         name: Models.foodEntry2.name,
                                         userId: Models.user2.id,
                                         thumbUrl: Models.foodEntry2.thumbUrl,
                                         date: Models.foodEntry2.date,
                                         time: Models.foodEntry2.time,
                                         timestamp: Models.foodEntry2.timestamp,
                                         calValue: Models.foodEntry2.calValue),
                       FoodEntryResponse(id: Models.foodEntry1.id,
                                         name: Models.foodEntry1.name,
                                         userId: Models.user2.id,
                                         thumbUrl: Models.foodEntry1.thumbUrl,
                                         date: Models.foodEntry1.date,
                                         time: Models.foodEntry1.time,
                                         timestamp: Models.foodEntry1.timestamp,
                                         calValue: Models.foodEntry1.calValue)]
        }
        
        completion(.success(entries))
    }
}
