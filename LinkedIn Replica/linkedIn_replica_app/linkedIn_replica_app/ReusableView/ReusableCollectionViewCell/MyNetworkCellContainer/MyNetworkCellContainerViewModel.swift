//
//  MyNetworkCellContainerViewModel.swift
//  linkedIn_replica_app
//
//  Created by Ahmed Mohiy on 12/02/2023.
//

import Foundation
import linkedin_models

class MyNetworkCellContainerViewModel {
    
    let persons: [PersonIdentity]
    
    init(persons: [PersonIdentity]) {
        self.persons = persons
    }
}
