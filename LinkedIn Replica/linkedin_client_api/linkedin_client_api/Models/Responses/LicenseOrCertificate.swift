//
//  LicenseOrCertificate.swift
//  linkedin_client_api
//
//  Created by Ahmed Mohiy on 26/01/2023.
//

import Foundation

struct LicenseOrCertificate: Encodable {
    let name: String
    let organizationName: String
    let issueDate: Date
    let expirationDate: Date?
    let certificateId: String?
    let certificateUrl: String?
    
    public enum CodingKeys: String, CodingKey {
        case name
        case organizationName = "organization_name"
        case issueDate = "issue_date"
        case expirationDate = "expiration_date"
        case certificateId = "certificate_id"
        case certificateUrl = "certificate_url"
    }
}
