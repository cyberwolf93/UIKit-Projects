//
//  MyNetworkCollectionViewCellViewModel.swift
//  linkedIn_replica_app
//
//  Created by Ahmed Mohiy on 12/02/2023.
//

import linkedin_models
import Foundation

class MyNetworkCollectionViewCellViewModel {
    let person: PersonIdentity
    
    init(person: PersonIdentity) {
        self.person = person
    }
}
