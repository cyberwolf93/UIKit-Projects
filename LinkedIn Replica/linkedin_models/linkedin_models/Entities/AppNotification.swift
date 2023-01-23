//
//  Notification.swift
//  linkedin_models
//
//  Created by Ahmed Mohiy on 23/01/2023.
//

import Foundation

public struct AppNotification {
    let title: String
    let iconUrl: String
    let type: NotificationType
    let action: NotificationAction
    let metaData: NotificationMetadata
}
