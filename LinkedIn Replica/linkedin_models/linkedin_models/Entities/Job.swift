//
//  job.swift
//  linkedin_models
//
//  Created by Ahmed Mohiy on 23/01/2023.
//

import Foundation

public struct Job {
    public let title: String
    public let iconUrl: String
    public let company: CompanyIdentity
    public let location: String
    public let workPlace: WorkPlaceType
    public var minSalary: String?
    public var maxSalary: String?
    public let date: Date
    public let isEasyApply: Bool = false
    public let numberOfApplicants: Int
    public let positionType: PositionType
    public let positionLevel: PositionLevelType
    public let topSkills: [String]
}
