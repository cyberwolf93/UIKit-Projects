//
//  AppNotification.swift
//  linkedin_client_api
//
//  Created by Ahmed Mohiy on 26/01/2023.
//

import Foundation

struct AppNotification: Encodable {
    let title: String
    let iconUrl: String
    let type: Int
    let action: NotificationAction
    let metaData: NotificationMetadata
    
    public enum CodingKeys: String, CodingKey {
        case title
        case iconUrl = "icon_url"
        case type
        case action
        case metaData
    }
}
