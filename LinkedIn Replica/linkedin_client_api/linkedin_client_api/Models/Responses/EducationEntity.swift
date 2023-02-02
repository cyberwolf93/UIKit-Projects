//
//  EducationEntity.swift
//  linkedin_client_api
//
//  Created by Ahmed Mohiy on 26/01/2023.
//

import Foundation
struct EducationEntity: Encodable {
    let schoolName: String
    let degree: String
    let fieldOfStudy: String
    let startDate: Date
    let endDate: Date
    let grade: String?
    let description: String?
    let country: String
    
    public enum CodingKeys: String, CodingKey {
        case schoolName = "school_name"
        case degree
        case fieldOfStudy = "field_of_study"
        case startDate = "start_date"
        case endDate = "end_date"
        case grade
        case description
        case country
    }
}
