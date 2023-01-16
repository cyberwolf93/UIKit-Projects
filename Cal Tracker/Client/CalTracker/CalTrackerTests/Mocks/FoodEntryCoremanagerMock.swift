//
//  FoodEntryCoremanagerMock.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 27/10/2022.
//

import Foundation
@testable import NetworkCore
@testable import CalTracker

class FoodEntryCoremanagerMock: FoodEntryCoreManager {
    
    // MARK: - Test Create new food Entry
    public override func createFoodEntry(request: CreateFoodEntryRequest, completion: @escaping (Result<FoodEntryResponse, Error>) -> Void ) {
      
        completion(.success(FoodEntryResponse(id: Models.foodEntry1.id,
                                              name: Models.foodEntry1.name,
                                              userId: Models.user2.id,
                                              thumbUrl: Models.foodEntry1.thumbUrl,
                                              date: Models.foodEntry1.date,
                                              time: Models.foodEntry1.time,
                                              timestamp: Models.foodEntry1.timestamp,
                                              calValue: Models.foodEntry1.calValue)))
        
        
    }
    
    
    // MARK: - test Uplaod image to server
    public override func uplaodImage(request: UploadImageRequest, completion: @escaping (Result<FoodEntryResponse, Error>) -> Void ) {
        
        completion(.success(FoodEntryResponse(id: Models.foodEntry1.id,
                                              name: Models.foodEntry1.name,
                                              userId: Models.user2.id,
                                              thumbUrl: Models.foodEntry1.thumbUrl,
                                              date: Models.foodEntry1.date,
                                              time: Models.foodEntry1.time,
                                              timestamp: Models.foodEntry1.timestamp,
                                              calValue: Models.foodEntry1.calValue)))
    }
    
    // MARK: - Test Update food Entry
    public override func updateFoodEntry(request: UpdateFoodEntryRequest, completion: @escaping (Result<FoodEntryResponse, Error>) -> Void ) {
        completion(.success(FoodEntryResponse(id: Models.foodEntry1.id,
                                              name: Models.foodEntry1.name,
                                              userId: Models.user2.id,
                                              thumbUrl: Models.foodEntry1.thumbUrl,
                                              date: Models.foodEntry1.date,
                                              time: Models.foodEntry1.time,
                                              timestamp: Models.foodEntry1.timestamp,
                                              calValue: Models.foodEntry1.calValue)))
        
    }
    
    // MARK: - Delete food Entry
    public override func deleteFoodEntry(request: DeleteFoodEntryRequest, completion: @escaping (Result<String, Error>) -> Void ) {
        
        if request.entryId.isEmpty || request.userId.isEmpty {
            completion(.failure( NetworkEngineError.badRequest))
        } else {
            completion(.success("OK"))
        }
        
    }
    
    
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
                                             calValue: Models.foodEntry2.calValue),
                       
                       FoodEntryResponse(id: Models.todayFoodEntry3.id,
                                         name: Models.todayFoodEntry3.name,
                                         userId: Models.user3.id,
                                         thumbUrl: Models.todayFoodEntry3.thumbUrl,
                                         date: Models.todayFoodEntry3.date,
                                         time: Models.todayFoodEntry3.time,
                                         timestamp: Models.todayFoodEntry3.timestamp,
                                         calValue: Models.todayFoodEntry3.calValue)]
            
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
        } else if request.userId == Models.user3.id {
            entries = [FoodEntryResponse(id: Models.todayFoodEntry3.id,
                                         name: Models.foodEntry2.name,
                                         userId: Models.user2.id,
                                         thumbUrl: Models.todayFoodEntry3.thumbUrl,
                                         date: Models.todayFoodEntry3.date,
                                         time: Models.todayFoodEntry3.time,
                                         timestamp: Models.todayFoodEntry3.timestamp,
                                         calValue: Models.todayFoodEntry3.calValue)]
        }
        
        
        completion(.success(entries))
        
    }
}
