//
//  HomeFeedCellViewModel.swift
//  linkedIn Replica
//
//  Created by Ahmed Mohiy on 02/02/2023.
//

import Foundation
import linkedin_models

class HomeFeedCellViewModel {
    let postData: Post
    var isCellExtended = false
    
    init(postData: Post) {
        self.postData = postData
    }
    
    //MARK: -  UI header view helper methods
    func headerTitle() -> String {
        if let post = postData as? PersonPost {
            return post.person.name
        }
        
        if let post = postData as? CompanyPost {
            return post.company.name
        }
        
        return ""
    }
    
    
    func headerSubTitle() -> String {
        if let post = postData as? PersonPost {
            return post.person.jobTitle
        }
        
        if let post = postData as? CompanyPost {
            return "\(post.company.numberOfFollowers) Followers"
        }
        
        return ""
    }
    
    func headerImageName() -> String {
        if let post = postData as? PersonPost {
            return post.person.profileImageUrl
        }
        
        if let post = postData as? CompanyPost {
            return post.company.profileImageUrl
        }
        
        return ""
    }
    
    func headerPublishDate() -> Date {
        return Date(timeIntervalSinceNow: -Double(Int.random(in: 1...Int(Date.NUMBER_OF_SECONDS_IN_YEAR))))
    }
}
