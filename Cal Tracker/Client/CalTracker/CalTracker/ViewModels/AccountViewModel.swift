//
//  AccountViewModel.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 25/10/2022.
//

import UIKit

class AccountViewModel {
    
    let appPrefrencess: AppPreferences
    var tableViewSections: [[Row]] = []
    
    // MARK: - Initialization
    init(appPrefrencess: AppPreferences = AppPreferences.shared) {
        self.appPrefrencess = appPrefrencess
    }
    
    // MARK: -
    func prepareTabelViewSection() {
        tableViewSections = [[Row.name, Row.email], [Row.signout]]
    }
    
    // MARK: - Retrieve UI data
    func getUserName() -> String{
        return appPrefrencess.getUser()?.name ?? ""
    }
    
    func getUserEmail() -> String{
        return appPrefrencess.getUser()?.email ?? ""
    }
    
    func getSectionTitle(type: Section) -> String {
        switch(type) {
        case .profileInformation:
            return String.localizedString(with: "profile_information_section_title")
        case .accountManagement:
            return String.localizedString(with: "account_managment_title")
        }
    }
    
    //MARK: - Actions
    func signout() {
        appPrefrencess.deleteUserInfo()
    }
    
    // MARK: - Enum for sections and cells name
    enum Section: Int {
        case profileInformation = 0
        case accountManagement = 1
    }
    
    enum Row: String {
        case name = "name"
        case email = "email"
        case signout = "Signout"
    }
    
}
