//
//  SigninResponse.swift
//  NetworkCore
//
//  Created by Ahmed Mohiy on 23/10/2022.
//

import Foundation

public struct SigninResponse: Codable {
    public let id: String
    public let name: String
    public let email: String
    public let token: String
    public let isAdmin: Bool
    public let calLimit: Int
    
    public enum CodingKeys: String, CodingKey {
        case isAdmin
        case calLimit = "cal_limit"
        case id
        case name
        case email
        case token
    }
}
