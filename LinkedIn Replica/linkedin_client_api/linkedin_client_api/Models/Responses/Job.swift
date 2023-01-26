//
//  Job.swift
//  linkedin_client_api
//
//  Created by Ahmed Mohiy on 26/01/2023.
//

import Foundation

struct Job: Encodable {
    let title: String
    let iconUrl: String
    let company: Company
    let location: String
    let workPlace: Int
    var minSalary: String?
    var maxSalary: String?
    let date: Date
    let isEasyApply: Bool = false
    let numberOfApplicants: Int
    let positionType: Int
    let positionLevel: Int
    let topSkills: [String]
    
    public enum CodingKeys: String, CodingKey {
        case title
        case iconUrl = "icon_url"
        case company
        case location
        case workPlace = "work_place"
        case minSalary = "min_salary"
        case maxSalary = "max_salary"
        case date
        case isEasyApply = "is_easy_apply"
        case numberOfApplicants = "number_of_applicants"
        case positionType = "position_type"
        case positionLevel = "position_level"
        case topSkills = "top_skills"
    }
}
