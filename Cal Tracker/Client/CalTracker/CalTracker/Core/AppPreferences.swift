//
//  AppPreferences.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 23/10/2022.
//

import Foundation
import NetworkCore

enum AppPreferencesKeys: String {
    case userInfo = "USER_INFO"
}

class AppPreferences {
    
    //MARK: Sengleton
    static let shared = AppPreferences()
    
    
    // MARK: Add user to userDefaults
    func saveUser(with user: SigninResponse) -> Bool {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            UserDefaults.standard.set(encoded, forKey: AppPreferencesKeys.userInfo.rawValue)
            return true
        }
        
        return false
        
    }
    
    // MARK: Get user info from userDefaults
    func getUser() -> SigninResponse? {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.object(forKey: AppPreferencesKeys.userInfo.rawValue) as? Data {
            if let userinfo = try? decoder.decode(SigninResponse.self, from: data) {
                return userinfo
            }
        }
        
        return  nil
    }
    
    // MARK: Return user auth token
    func getUserToken() -> String {
        return getUser()?.token ?? ""
    }
    
    // MARK: Return user id
    func getUserId() -> String {
        return getUser()?.id ?? ""
    }
    
    //MARK: Delete user info for sign out purpose
    func deleteUserInfo() {
        UserDefaults.standard.removeObject(forKey: AppPreferencesKeys.userInfo.rawValue)
    }
}
