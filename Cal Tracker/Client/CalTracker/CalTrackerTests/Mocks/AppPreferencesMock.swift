//
//  AppPreferencesMock.swift
//  CalTrackerTests
//
//  Created by Ahmed Mohiy on 27/10/2022.
//

import Foundation
@testable import CalTracker
@testable import NetworkCore

class AppPreferencesMock: AppPreferences {
    
    var user: SigninResponse?
    
    
    // MARK: Add user to userDefaults
    override func saveUser(with user: SigninResponse) -> Bool {
        self.user = user
        return true
    }
    
    // MARK: Get user info from userDefaults
    override func getUser() -> SigninResponse? {
        return user
    }
    
    // MARK: Return user auth token
    override func getUserToken() -> String {
        return user?.token ?? ""
    }
    
    // MARK: Return user id
    override func getUserId() -> String {
        return user?.id ?? ""
    }
    
    //MARK: Delete user info for sign out purpose
    override func deleteUserInfo() {
        user = nil
    }
}
