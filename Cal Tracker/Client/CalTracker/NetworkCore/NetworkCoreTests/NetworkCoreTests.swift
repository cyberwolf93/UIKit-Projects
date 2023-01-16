//
//  NetworkCoreTests.swift
//  NetworkCoreTests
//
//  Created by Ahmed Mohiy on 12/01/2022.
//

import XCTest
@testable import NetworkCore


class UserCoreManagerTests: XCTestCase {

    // test user loged in should success
    func testSigninSuccess() {
        let engine = SigninEngineMock()
        let req = SigninRequest(email: Models.user1["email"] as! String,
                                password: "1234567")
        let expectation = expectation(description: "testSignin")
        var user: SigninResponse?
        let usercore = UserCoreManager(engine: engine, authToken: "")
        usercore.signin(request: req) { result in
            switch(result) {
            case .success(let signedUser):
                user = signedUser
                expectation.fulfill()
            case .failure(_ ):
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertNotNil(user)
        XCTAssertEqual(user!.email, Models.user1["email"] as! String)
    }
    
    // test user loged in should success
    func testSigninFailed() {
        let engine = SigninEngineMock()
        let req = SigninRequest(email: "",
                                password: "1234567")
        let expectation = expectation(description: "testSignin")
        var user: SigninResponse?
        let usercore = UserCoreManager(engine: engine, authToken: "")
        usercore.signin(request: req) { result in
            switch(result) {
            case .success(let signedUser):
                user = signedUser
                expectation.fulfill()
            case .failure(_ ):
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertNil(user)
       
    }
    
    // test fetch all user data
    func testFetchAllUsers() {
        let engine = FetchAllUserEngineMock()
        let req = FetchAllUsersRequest()
        let expectation = expectation(description: "testFetchAllUsers")
        var user: [SigninResponse] = []
        UserCoreManager(engine: engine, authToken: "").fetchAllUsers(request: req) { result in
            switch(result) {
            case .success(let usersList):
                user = usersList
                expectation.fulfill()
            case .failure(_ ):
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertNotNil(user)
        XCTAssertEqual(user.count, 2)
       
    }
    
    // test update calLimit success
    func testUpdateUserCaloriesLimit() {
        let engine = UpdateUserCaloriesLimitEngineMock()
        let req = UpdateUserCaloriesLimitRequest(calLimit: 10)
        let expectation = expectation(description: "testUpdateUserCaloriesLimit")
        var user: SigninResponse?
        UserCoreManager(engine: engine, authToken: "12321").UpdateUserCaloriesLimit(request: req) { result in
            switch(result) {
            case .success(let userObject):
                user = userObject
                expectation.fulfill()
            case .failure(_ ):
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertNotNil(user)
        XCTAssertEqual(user!.email, Models.user1["email"] as! String)
       
    }
    
    // test update calLimit failed
    func testUpdateUserCaloriesLimitFailure() {
        let engine = UpdateUserCaloriesLimitEngineMock()
        let req = UpdateUserCaloriesLimitRequest(calLimit: 10)
        let expectation = expectation(description: "testUpdateUserCaloriesLimit")
        var user: SigninResponse?
        UserCoreManager(engine: engine, authToken: "").UpdateUserCaloriesLimit(request: req) { result in
            switch(result) {
            case .success(let userObject):
                user = userObject
                expectation.fulfill()
            case .failure(_ ):
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertNil(user)
       
    }
    
    // test validate user
    func testValidateUser() {
        let engine = ValidateUserEngineMock()
        let req = ValidateUserRequest(userId: Models.user1["id"]! as! String)
        let expectation = expectation(description: "ValidateUserEngineMock")
        var succeeded = false
        UserCoreManager(engine: engine, authToken: "112321").validateUser(request: req) { result in
            switch(result) {
            case .success(_ ):
                succeeded = true
                expectation.fulfill()
            case .failure(_ ):
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertTrue(succeeded)
       
    }
    
    // test validate user failure
    func testValidateUserFailure() {
        let engine = ValidateUserEngineMock()
        let req = ValidateUserRequest(userId: Models.user1["id"]! as! String)
        let expectation = expectation(description: "ValidateUserEngineMock")
        var succeeded = false
        UserCoreManager(engine: engine, authToken: "").validateUser(request: req) { result in
            switch(result) {
            case .success(_ ):
                succeeded = true
                expectation.fulfill()
            case .failure(_ ):
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertFalse(succeeded)
       
    }

}
