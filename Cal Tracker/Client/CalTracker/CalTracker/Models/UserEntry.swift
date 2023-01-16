//
//  UserEntry.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 25/10/2022.
//

import Foundation
import NetworkCore

struct UserEntry {
    
    public let id: String
    public let name: String
    public let email: String
    public let token: String
    public let isAdmin: Bool
    public let calLimit: Int
    
    init(id: String, name: String, email: String, token: String, isAdmin: Bool, calLimit: Int) {
        self.id = id
        self.name = name
        self.email = email
        self.token = token
        self.isAdmin = isAdmin
        self.calLimit = calLimit
    }
    
    init(from user : SigninResponse) {
        self.id = user.id
        self.name = user.name
        self.email = user.email
        self.token = user.token
        self.isAdmin = user.isAdmin
        self.calLimit = user.calLimit
    }
}
