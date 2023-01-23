//
//  job.swift
//  linkedin_models
//
//  Created by Ahmed Mohiy on 23/01/2023.
//

import Foundation

public struct Job {
    let title: String
    let iconUrl: String
    let company: CompanyIdentity
    let location: String
    let workPlace: WorkPlaceType
    var minSalary: String?
    var maxSalary: String?
    let date: Date
    let isEasyApply: Bool = false
    let numberOfApplicants: Int
    let positionType: PositionType
    let positionLevel: PositionLevelType
    let topSkills: [String]
}
