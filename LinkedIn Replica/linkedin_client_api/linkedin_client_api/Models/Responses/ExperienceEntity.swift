//
//  ExperienceEntity.swift
//  linkedin_client_api
//
//  Created by Ahmed Mohiy on 26/01/2023.
//

import Foundation

struct ExperienceEntity: Encodable {
    let title: String
    let headline: String
    let positionType: Int
    let location: String
    let isCurrentyActive: Bool
    let startDate: Date
    let endDate: Date?
    let description: String
    let company: Company
    let skills: [String]
    
    public enum CodingKeys: String, CodingKey {
        case title
        case headline
        case positionType = "position_type"
        case location
        case isCurrentyActive = "is_currenty_active"
        case startDate = "start_date"
        case endDate = "end_date"
        case description
        case company
        case skills
    }
    
}
