//
//  Notification.swift
//  linkedin_models
//
//  Created by Ahmed Mohiy on 23/01/2023.
//

import Foundation

public struct AppNotification {
    public let title: String
    public let iconUrl: String
    public let type: NotificationType
    public let action: NotificationAction
    public let metaData: NotificationMetadata
}
