//
//  GetFoodEntriesEngineMock.swift
//  NetworkCoreTests
//
//  Created by Ahmed Mohiy on 28/10/2022.
//

import XCTest
@testable import NetworkCore

class GetFoodEntriesEngineMock: NetworkEngineProtocol {
    var urlRequest: URLRequest?
    
    
    func excute(completion: @escaping (Result<Data, Error>) -> Void) {
        
        do {
            let data = try JSONSerialization.data(withJSONObject: Models.groupFoodEntries, options: .prettyPrinted)
            
            completion(.success(data))
        } catch {
            completion(.failure(NetworkEngineError.invalidData))
        }
    }
}
