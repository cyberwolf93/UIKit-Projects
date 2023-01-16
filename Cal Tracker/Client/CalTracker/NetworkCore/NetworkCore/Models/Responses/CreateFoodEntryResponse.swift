//
//  CreateFoodEntryResponse.swift
//  NetworkCore
//
//  Created by Ahmed Mohiy on 23/10/2022.
//

import Foundation

public struct FoodEntryResponse: Decodable {
    public let id: String
    public let name: String
    public let userId: String
    public let thumbUrl: String
    public let date: String
    public let time: String
    public let timestamp: Int
    public let calValue: Int
    
    public enum CodingKeys: String, CodingKey {
        case id
        case name
        case userId
        case thumbUrl
        case date
        case time
        case timestamp
        case calValue = "cal_value"
    }
    
    
}


