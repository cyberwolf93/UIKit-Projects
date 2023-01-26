//
//  PersonIdentity.swift
//  linkedin_models
//
//  Created by Ahmed Mohiy on 23/01/2023.
//

import Foundation

public struct PersonIdentity: Identity {
    public let id: String
    public let name: String
    public let profileImageUrl: String
    public let coverImageUrl: String
    public let jobTitle: String
    public var currentCompany: CompanyIdentity?
    public let about: String
    public let experience: [ExperienceEntity] = []
    public let education: [EducationEntity] = []
    public let licensesAndCerts: [LicenseOrCertificate] = []
    public let skills: [String] = []
}
