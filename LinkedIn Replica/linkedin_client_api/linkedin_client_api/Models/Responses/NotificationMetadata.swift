//
//  NotificationMetadata.swift
//  linkedin_client_api
//
//  Created by Ahmed Mohiy on 26/01/2023.
//

import Foundation

struct NotificationMetadata: Encodable {
    var job: Job?
    var title: String?
    var link: String?
    var person: Person?
    var post: Post?
}
