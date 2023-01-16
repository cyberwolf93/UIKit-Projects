//
//  FetchAllUserEngineMock.swift
//  NetworkCoreTests
//
//  Created by Ahmed Mohiy on 28/10/2022.
//

import XCTest
@testable import NetworkCore

class FetchAllUserEngineMock: NetworkEngineProtocol {
    var urlRequest: URLRequest?
    
    
    func excute(completion: @escaping (Result<Data, Error>) -> Void) {
        do {
            let data = try JSONSerialization.data(withJSONObject: Models.groupUsers, options: .prettyPrinted)
            
            completion(.success(data))
        } catch {
            completion(.failure(NetworkEngineError.invalidData))
        }
            
    }
}
