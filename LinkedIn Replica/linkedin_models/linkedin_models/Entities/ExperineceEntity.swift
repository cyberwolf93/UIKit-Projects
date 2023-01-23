//
//  ExperineceEntity.swift
//  linkedin_models
//
//  Created by Ahmed Mohiy on 23/01/2023.
//

import Foundation

public struct ExperineceEntity {
    let title: String
    let headline: String
    let positionType: String
    let location: String
    let isCurrentyActive: Bool
    let startDate: Date
    let endDate: Date
    let description: String
    let company: CompanyIdentity
    let skills: [String]
}
