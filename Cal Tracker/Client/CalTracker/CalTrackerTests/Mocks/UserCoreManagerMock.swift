//
//  UserCoreManagerMock.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 27/10/2022.
//

import Foundation
@testable import NetworkCore
@testable import CalTracker

class UserCoreManagerMock: UserCoreManager {
    
    // MARK: - test sign in
    public override func signin(request: SigninRequest, completion: @escaping (Result<SigninResponse, Error>) -> Void ) {
        
        completion(.success(SigninResponse(id: Models.user1.id,
                                           name: Models.user1.name,
                                           email: Models.user1.email,
                                           token: Models.user1.token,
                                           isAdmin: Models.user1.isAdmin,
                                           calLimit: Models.user1.calLimit)))
    }
    
    // MARK: - test Featch all users
    public override func fetchAllUsers(request: FetchAllUsersRequest, completion: @escaping (Result<[SigninResponse], Error>) -> Void ) {
        
        let response = [
            SigninResponse(id: Models.user1.id,
                           name: Models.user1.name,
                           email: Models.user1.email,
                           token: Models.user1.token,
                           isAdmin: Models.user1.isAdmin,
                           calLimit: Models.user1.calLimit),
            
            SigninResponse(id: Models.user2.id,
                           name: Models.user2.name,
                           email: Models.user2.email,
                           token: Models.user2.token,
                           isAdmin: Models.user2.isAdmin,
                           calLimit: Models.user2.calLimit)
        ]
        
        completion(.success(response))
    }
    
    
    // MARK: - Test Update user calories limit
    public override func UpdateUserCaloriesLimit(request: UpdateUserCaloriesLimitRequest, completion: @escaping (Result<SigninResponse, Error>) -> Void ) {
        
        
        
        completion(.success(SigninResponse(id: Models.user2.id,
                                           name: Models.user2.name,
                                           email: Models.user2.email,
                                           token: Models.user2.token,
                                           isAdmin: Models.user2.isAdmin,
                                           calLimit: request.calLimit)))
        
    }
    
    
    // MARK: - Validate User Token
    public override func validateUser(request: ValidateUserRequest, completion: @escaping (Result<String, Error>) -> Void ) {
        if request.userId.isEmpty {
            completion(.failure(NetworkEngineError.badRequest))
            return
        }
        
        completion(.success("ok"))
        
    }
    
    
}
