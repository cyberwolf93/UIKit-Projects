//
//  LicenseOrCertificate.swift
//  linkedin_models
//
//  Created by Ahmed Mohiy on 23/01/2023.
//

import Foundation

public struct LicenseOrCertificate {
    let name: String
    let organizationName: String
    let issueDate: Date
    let expirationDate: Date?
    let certificateId: String?
    let certificateUrl: String?
}
