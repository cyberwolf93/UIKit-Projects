//
//  PersonIdentity.swift
//  linkedin_models
//
//  Created by Ahmed Mohiy on 23/01/2023.
//

import Foundation

public struct PersonIdentity {
    let jobTitle: String
    var currentCompany: CompanyIdentity?
    let about: String
    let experience: [ExperineceEntity] = []
    let education: [EducationEntity] = []
    let licensesAndCerts: [LicenseOrCertificate] = []
    let skills: [String] = []
}
