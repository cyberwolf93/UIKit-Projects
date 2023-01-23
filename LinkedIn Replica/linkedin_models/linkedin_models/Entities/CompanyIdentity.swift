//
//  CompanyIdentity.swift
//  linkedin_models
//
//  Created by Ahmed Mohiy on 23/01/2023.
//

import Foundation

public struct CompanyIdentity {
    let industry: IndustryType
    let numberOfFollowers: Int64
    let overView: String
    let website: String
    let companySize: Int
    let headquarters: String
    let type: CompanyType
    let specialities: String
    let funding: [Funding]
    let locations: [LocationEntity]
}
