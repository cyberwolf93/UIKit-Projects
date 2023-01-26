//
//  LocationEntity.swift
//  linkedin_client_api
//
//  Created by Ahmed Mohiy on 26/01/2023.
//

import Foundation

struct LocationEntity: Encodable {
    let address: String
    let isPrimary: Bool
    let latitude: String
    let longitude: String
    let country: String
    
    public enum CodingKeys: String, CodingKey {
        case address
        case isPrimary = "is_primary"
        case latitude
        case longitude
        case country
        
    }
}
