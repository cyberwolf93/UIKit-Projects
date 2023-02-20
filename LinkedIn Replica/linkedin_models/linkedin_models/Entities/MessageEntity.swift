//
//  MessageEntity.swift
//  linkedin_models
//
//  Created by Ahmed Mohiy on 13/02/2023.
//

import Foundation

public struct MessageEntity {
    public let message: [String]
    public let person: PersonIdentity
    public let date: Date
    
    public init(message: [String], person: PersonIdentity, date: Date) {
        self.message = message
        self.person = person
        self.date = date
    }
}
