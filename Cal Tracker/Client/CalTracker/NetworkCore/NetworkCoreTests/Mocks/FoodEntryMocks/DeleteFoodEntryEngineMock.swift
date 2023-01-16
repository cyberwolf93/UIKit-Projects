//
//  DeleteFoodEntryEngineMock.swift
//  NetworkCoreTests
//
//  Created by Ahmed Mohiy on 28/10/2022.
//

import XCTest
@testable import NetworkCore

class DeleteFoodEntryEngineMock: NetworkEngineProtocol {
    var urlRequest: URLRequest?
    
    
    func excute(completion: @escaping (Result<Data, Error>) -> Void) {
        
        do {
            if let headerAuth = urlRequest?.allHTTPHeaderFields?["Authorization"], !headerAuth.isEmpty {
                let data = try JSONSerialization.data(withJSONObject: Models.foodEntry1, options: .prettyPrinted)
                
                completion(.success(data))
                return
            }
            completion(.failure(NetworkEngineError.invalidData))
        } catch {
            completion(.failure(NetworkEngineError.invalidData))
        }
    }
}
