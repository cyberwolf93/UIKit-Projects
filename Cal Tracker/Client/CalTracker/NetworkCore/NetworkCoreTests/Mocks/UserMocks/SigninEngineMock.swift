//
//  SigninEngineMock.swift
//  NetworkCoreTests
//
//  Created by Ahmed Mohiy on 28/10/2022.
//

import XCTest
@testable import NetworkCore

class SigninEngineMock: NetworkEngineProtocol {
    var urlRequest: URLRequest?
    
    
    func excute(completion: @escaping (Result<Data, Error>) -> Void) {
        if let data = urlRequest?.httpBody {
            do {
                let object = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                guard let email = object?[SigninRequest.bodykeys.email.rawValue] as? String else {
                    completion(.failure(NetworkEngineError.invalidData))
                    return
                }
                
                if email.isEmpty {
                    completion(.failure(NetworkEngineError.notFound))
                    return
                }
                
                guard let _ = object?[SigninRequest.bodykeys.password.rawValue] as? String else {
                    completion(.failure(NetworkEngineError.invalidData))
                    return
                }
                
                let data = try JSONSerialization.data(withJSONObject: Models.user1, options: .prettyPrinted)
                
                completion(.success(data))
                
            } catch {
                completion(.failure(NetworkEngineError.invalidData))
            }
        }
    }
}
