//
//  CompanyIdentity.swift
//  linkedin_models
//
//  Created by Ahmed Mohiy on 23/01/2023.
//

import Foundation

public struct CompanyIdentity: Identity {
    public let id: String
    public let name: String
    public let profileImageUrl: String
    public let coverImageUrl: String
    public let industry: IndustryType
    public let numberOfFollowers: Int64
    public let overView: String
    public let website: String
    public let companySize: Int
    public let headquarters: String
    public let type: CompanyType
    public let specialities: String
    public let funding: [Funding]
    public let locations: [LocationEntity]
}
