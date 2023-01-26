//
//  Company.swift
//  linkedin_client_api
//
//  Created by Ahmed Mohiy on 26/01/2023.
//

import Foundation

struct Company: Encodable {
    let id: String
    let name: String
    let profileImageUrl: String
    let coverImageUrl: String
    let industry: String
    let numberOfFollowers: Int64
    let overView: String
    let website: String
    let companySize: Int
    let headquarters: String
    let type: Int
    let specialities: String
    let funding: [Funding]
    let locations: [LocationEntity]
    
    public enum CodingKeys: String, CodingKey {
        case id
        case name
        case profileImageUrl = "profile_image_url"
        case coverImageUrl = "cover_image_url"
        case industry
        case numberOfFollowers = "number_of_followers"
        case overView
        case website
        case companySize = "company_size"
        case headquarters
        case type
        case specialities
        case funding
        case locations
    }
}
