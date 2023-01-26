//
//  SigninResponse.swift
//  NetworkCore
//
//  Created by Ahmed Mohiy on 23/10/2022.
//

import Foundation

struct Person: Encodable {
    let id: String
    let name: String
    let profileImageUrl: String
    let coverImageUrl: String
    let jobTitle: String
    var currentCompany: Company?
    let about: String
    let experience: [ExperienceEntity] = []
    let education: [EducationEntity] = []
    let licensesAndCerts: [LicenseOrCertificate] = []
    let skills: [String] = []
    
    public enum CodingKeys: String, CodingKey {
        case id
        case name
        case profileImageUrl = "profile_image_url"
        case coverImageUrl = "cover_image_url"
        case jobTitle = "job_title"
        case currentCompany = "current_company"
        case about
        case experience
        case education
        case licensesAndCerts = "licenses_and_certs"
        case skills
    }
}
