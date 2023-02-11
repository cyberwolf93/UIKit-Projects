//
//  SideMenuViewControllerViewModel.swift
//  linkedIn_replica_app
//
//  Created by Ahmed Mohiy on 11/02/2023.
//

import Foundation
import linkedin_models

class SideMenuViewControllerViewModel {
    
    private let person: PersonIdentity
    
    var profilePictureName: String {
        return person.profileImageUrl
    }
    
    var profileName: String {
        return person.name
    }
    
    init() {
        self.person = PersonIdentity(id: "1",
                                     name: "Ahmed Mohiy",
                                     profileImageUrl: "profile_1",
                                     coverImageUrl: "",
                                     jobTitle: "iOS engineer",
                                     currentCompany: nil,
                                     about: "")
    }
    
    
    
}
