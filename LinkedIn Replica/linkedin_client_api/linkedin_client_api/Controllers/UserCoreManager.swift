//
//  UserCoreManager.swift
//  NetworkCore
//
//  Created by Ahmed Mohiy on 22/10/2022.
//

import Foundation

public class UserCoreManager: NetworkCoreManager {
    public override init(engine: NetworkEngineProtocol, authToken: String) {
        super.init(engine: engine, authToken: authToken)
    }
    
    // MARK:- Sign in user
    public func signin(request: SigninRequest, completion: @escaping (Result<SigninResponse, Error>) -> Void ) {
        
        guard let req = request.build(baseUrl: BaseUrls.userBaseUrl, authToken: self.authToken) else {
            completion(.failure(NetworkEngineError.invalidUrl))
            return
        }
        engine.urlRequest = req
        // calling excute function on the engine to get the data from the backend
        engine.excute { result in
            switch result {
            case .success(let data):
                do {
                    let user = try JSONDecoder().decode(SigninResponse.self, from: data)
                    completion(.success(user))
                } catch {
                    completion(.failure(NetworkEngineError.invalidData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        
    }
    
    // MARK:- Featch all users
    public func fetchAllUsers(request: FetchAllUsersRequest, completion: @escaping (Result<[SigninResponse], Error>) -> Void ) {
        
        guard let req = request.build(baseUrl: BaseUrls.userBaseUrl, authToken: self.authToken) else {
            completion(.failure(NetworkEngineError.invalidUrl))
            return
        }
        engine.urlRequest = req
        // calling excute function on the engine to get the data from the backend
        engine.excute { result in
            switch result {
            case .success(let data):
                do {
                    let user = try JSONDecoder().decode([SigninResponse].self, from: data)
                    completion(.success(user))
                } catch{
                    completion(.failure(NetworkEngineError.invalidData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        
    }
    
    // MARK:- Update user calories limit
    public func UpdateUserCaloriesLimit(request: UpdateUserCaloriesLimitRequest, completion: @escaping (Result<SigninResponse, Error>) -> Void ) {
        
        guard let req = request.build(baseUrl: BaseUrls.userBaseUrl, authToken: self.authToken) else {
            completion(.failure(NetworkEngineError.invalidUrl))
            return
        }
        engine.urlRequest = req
        // calling excute function on the engine to get the data from the backend
        engine.excute { result in
            switch result {
            case .success(let data):
                do {
                    let user = try JSONDecoder().decode(SigninResponse.self, from: data)
                    completion(.success(user))
                } catch{
                    completion(.failure(NetworkEngineError.invalidData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        
    }
    
    // MARK:- Validate User Token
    public func validateUser(request: ValidateUserRequest, completion: @escaping (Result<String, Error>) -> Void ) {
        
        guard let req = request.build(baseUrl: BaseUrls.userBaseUrl, authToken: self.authToken) else {
            completion(.failure(NetworkEngineError.invalidUrl))
            return
        }
        engine.urlRequest = req
        // calling excute function on the engine to get the data from the backend
        engine.excute { result in
            switch result {
            case .success(_ ):
                completion(.success("ok"))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        
    }
}
