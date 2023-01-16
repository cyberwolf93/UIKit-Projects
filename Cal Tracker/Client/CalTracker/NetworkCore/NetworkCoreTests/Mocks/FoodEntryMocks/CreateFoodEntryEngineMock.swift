//
//  CreateFoodEntryEngineMock.swift
//  NetworkCoreTests
//
//  Created by Ahmed Mohiy on 28/10/2022.
//

import XCTest
@testable import NetworkCore

class CreateFoodEntryEngineMock: NetworkEngineProtocol {
    var urlRequest: URLRequest?
    
    
    func excute(completion: @escaping (Result<Data, Error>) -> Void) {
        
        do {
            let data = try JSONSerialization.data(withJSONObject: Models.foodEntry1, options: .prettyPrinted)
            
            completion(.success(data))
        } catch {
            completion(.failure(NetworkEngineError.invalidData))
        }
    }
}
