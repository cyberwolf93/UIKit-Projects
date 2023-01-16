//
//  SplashViewModel.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 27/10/2022.
//

import Foundation
import NetworkCore

protocol SplashViewModelDelegate: NSObjectProtocol {
    func userCredentialsValid()
    func userCredentialsNotValid()
}

class SplashViewModel {
    
    let userCoreManager: UserCoreManager
    let appPrefrences: AppPreferences
    weak var delegate: SplashViewModelDelegate?
    
    
    init(userCoreManager: UserCoreManager, appPrefrences: AppPreferences = AppPreferences.shared) {
        self.userCoreManager = userCoreManager
        self.appPrefrences = appPrefrences
    }
    
    //MARK: - Validate user
    func validateUser() {
        let request = ValidateUserRequest(userId: appPrefrences.getUserId())
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.userCoreManager.validateUser(request: request) { result in
                switch(result) {
                case .success(_):
                    self?.delegate?.userCredentialsValid()
                case .failure(_):
                    self?.delegate?.userCredentialsNotValid()
                    
                }
            }
        }
    }
    
    func signout() {
        appPrefrences.deleteUserInfo()
    }
    
}
