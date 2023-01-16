//
//  FoodEntryCoreManager.swift
//  NetworkCore
//
//  Created by Ahmed Mohiy on 22/10/2022.
//

import Foundation

public class FoodEntryCoreManager: NetworkCoreManager {
    
    public override init(engine: NetworkEngineProtocol, authToken: String) {
        super.init(engine: engine, authToken: authToken)
    }
    
    
    // MARK:- Create new food Entry
    public func createFoodEntry(request: CreateFoodEntryRequest, completion: @escaping (Result<FoodEntryResponse, Error>) -> Void ) {
        
        guard let req = request.build(baseUrl: BaseUrls.foodEntry, authToken: self.authToken) else {
            completion(.failure(NetworkEngineError.invalidUrl))
            return
        }
        engine.urlRequest = req
        // calling excute function on the engine to get the data from the backend
        engine.excute { result in
            switch result {
            case .success(let data):
                do {
                    let foodEntry = try JSONDecoder().decode(FoodEntryResponse.self, from: data)
                    completion(.success(foodEntry))
                } catch {
                    completion(.failure(NetworkEngineError.invalidData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        
    }
    
    // MARK:- Uplaod image to server
    public func uplaodImage(request: UploadImageRequest, completion: @escaping (Result<FoodEntryResponse, Error>) -> Void ) {
        
        guard let req = request.build(baseUrl: BaseUrls.foodEntry, authToken: self.authToken) else {
            completion(.failure(NetworkEngineError.invalidUrl))
            return
        }
        engine.urlRequest = req
        // calling excute function on the engine to get the data from the backend
        engine.excute { result in
            switch result {
            case .success(let data):
                do {
                    let foodEntry = try JSONDecoder().decode(FoodEntryResponse.self, from: data)
                    completion(.success(foodEntry))
                } catch {
                    completion(.failure(NetworkEngineError.invalidData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        
    }
    
    // MARK:- Update food Entry
    public func updateFoodEntry(request: UpdateFoodEntryRequest, completion: @escaping (Result<FoodEntryResponse, Error>) -> Void ) {
        
        guard let req = request.build(baseUrl: BaseUrls.foodEntry, authToken: self.authToken) else {
            completion(.failure(NetworkEngineError.invalidUrl))
            return
        }
        engine.urlRequest = req
        // calling excute function on the engine to get the data from the backend
        engine.excute { result in
            switch result {
            case .success(let data):
                do {
                    let foodEntry = try JSONDecoder().decode(FoodEntryResponse.self, from: data)
                    completion(.success(foodEntry))
                } catch {
                    completion(.failure(NetworkEngineError.invalidData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        
    }
    
    // MARK:- Delete food Entry
    public func deleteFoodEntry(request: DeleteFoodEntryRequest, completion: @escaping (Result<String, Error>) -> Void ) {
        
        guard let req = request.build(baseUrl: BaseUrls.foodEntry, authToken: self.authToken) else {
            completion(.failure(NetworkEngineError.invalidUrl))
            return
        }
        engine.urlRequest = req
        // calling excute function on the engine to get the data from the backend
        engine.excute { result in
            switch result {
            case .success( _):
                completion(.success("OK"))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        
    }
    
    // MARK: get all food entry for user using user id
    public func getEntries(request: GetFoodEntriesRequest, completion: @escaping (Result<[FoodEntryResponse], Error>) -> Void ) {
        guard let req = request.build(baseUrl: BaseUrls.foodEntry, authToken: self.authToken) else {
            completion(.failure(NetworkEngineError.invalidUrl))
            return
        }
        engine.urlRequest = req
        // calling excute function on the engine to get the data from the backend
        engine.excute { result in
            switch result {
            case .success(let data):
                do {
                    let foodEntry = try JSONDecoder().decode([FoodEntryResponse].self, from: data)
                    completion(.success(foodEntry))
                } catch {
                    completion(.failure(NetworkEngineError.invalidData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
