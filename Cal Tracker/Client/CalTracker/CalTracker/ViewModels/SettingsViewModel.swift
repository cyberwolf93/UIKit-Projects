//
//  SettingsViewModel.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 27/10/2022.
//

import Foundation
import NetworkCore
class SettingsViewModel {
    
    let appPrefrencess: AppPreferences
    let userCoreManager: UserCoreManager
    var tableViewList: [Cell] = []
    
    // MARK: - Initialization
    init(appPrefrencess: AppPreferences = AppPreferences.shared, userCoreManager: UserCoreManager) {
        self.appPrefrencess = appPrefrencess
        self.userCoreManager = userCoreManager
    }
    
    // MARK: - Helper methods
    func prepareTabelViewSection() {
        tableViewList = []
        if let user = appPrefrencess.getUser(), user.isAdmin {
            tableViewList = [Cell.report]
        } else {
            tableViewList = [Cell.calLimit]
        }
    }
    
    func getUserLimit() -> Int {
        return appPrefrencess.getUser()?.calLimit ?? 0
    }
    
    func changeLimit(With newLimit: Int, completion: @escaping () -> ()){
        let request = UpdateUserCaloriesLimitRequest(calLimit: newLimit)
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.userCoreManager.UpdateUserCaloriesLimit (request: request, completion: { result in
                switch(result) {
                case .success(let userInfo):
                    _ = self?.appPrefrencess.saveUser(with: userInfo)
                    completion()
                case .failure(_):
                    completion()
                }
            })
        }
    }
    
    // MARK: - Enum for sections and cells name
    enum Cell: String {
        case calLimit = "calLimit"
        case report = "report"
    }
    
}
