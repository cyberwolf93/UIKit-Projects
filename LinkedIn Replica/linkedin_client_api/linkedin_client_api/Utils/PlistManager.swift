//
//  PlistManager.swift
//  linkedin_client_api
//
//  Created by Ahmed Mohiy on 26/01/2023.
//

import Foundation

class PlistManager {
    static let `default`: PlistManager = PlistManager()
    static let bundleIdentifier = "com.amohiy.linkedinmodels.linkedin.client.api"
    
    
    var feedBaseUrl: String {
        if let dictionary = Bundle(identifier: Self.bundleIdentifier)?.infoDictionary {
            return dictionary["feed_base_url"] as? String ?? ""
        }
        return  ""
    }
    
    var notificationBaseUrl: String {
        if let dictionary = Bundle(identifier: Self.bundleIdentifier)?.infoDictionary {
            return dictionary["notification_base_url"] as? String ?? ""
        }
        return  ""
    }
    
    var jobBaseUrl: String {
        if let dictionary = Bundle(identifier: Self.bundleIdentifier)?.infoDictionary {
            return dictionary["job_base_url"] as? String ?? ""
        }
        return  ""
    }
    
}
