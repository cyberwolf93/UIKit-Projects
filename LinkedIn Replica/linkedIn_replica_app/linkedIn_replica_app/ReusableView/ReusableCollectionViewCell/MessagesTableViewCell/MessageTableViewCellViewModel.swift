//
//  MessageTableViewCellViewModel.swift
//  linkedIn_replica_app
//
//  Created by Ahmed Mohiy on 13/02/2023.
//

import Foundation
import linkedin_models

class MessageTableViewCellViewModel {
    let message: MessageEntity
    
    init(message: MessageEntity) {
        self.message = message
    }
}
