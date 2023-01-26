//
//  ExperineceEntity.swift
//  linkedin_models
//
//  Created by Ahmed Mohiy on 23/01/2023.
//

import Foundation

public struct ExperienceEntity {
    public let title: String
    public let headline: String
    public let positionType: String
    public let location: String
    public let isCurrentyActive: Bool
    public let startDate: Date
    public let endDate: Date
    public let description: String
    public let company: CompanyIdentity
    public let skills: [String]
}
