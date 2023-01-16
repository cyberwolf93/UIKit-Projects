//
//  SigninViewModel.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 23/10/2022.
//

import Foundation
import NetworkCore

protocol SigninViewModelDelegate: NSObjectProtocol {
    func signinDidSucceeded()
    func signinDidFailed(error: Error?)
}

class SigninViewModel {
    
    let userCoreManager: UserCoreManager
    let appPrefrences: AppPreferences
    weak var delegate: SigninViewModelDelegate?
    
    init(userCoreManager: UserCoreManager, appPrefrences: AppPreferences = AppPreferences.shared) {
        self.userCoreManager = userCoreManager
        self.appPrefrences = appPrefrences
    }
    
    //MARK:- Api functions
    func signin(email: String, password: String) {
        let request = SigninRequest(email: email, password: password)
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.userCoreManager.signin(request: request, completion: { result in
                switch(result) {
                case .success(let userInfo):
                    let success = self?.appPrefrences.saveUser(with: userInfo)
                    if let success {
                        self?.delegate?.signinDidSucceeded()
                    } else {
                        self?.delegate?.signinDidFailed(error: nil)
                    }
                case .failure(let error):
                    self?.delegate?.signinDidFailed(error: error)
                }
            })
        }
    }
    
}
