//
//  LicenseOrCertificate.swift
//  linkedin_models
//
//  Created by Ahmed Mohiy on 23/01/2023.
//

import Foundation

public struct LicenseOrCertificate {
    public let name: String
    public let organizationName: String
    public let issueDate: Date
    public let expirationDate: Date?
    public let certificateId: String?
    public let certificateUrl: String?
}
