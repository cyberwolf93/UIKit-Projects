//
//  Post.swift
//  linkedin_client_api
//
//  Created by Ahmed Mohiy on 26/01/2023.
//

import Foundation

struct Post: Encodable {
    var title: String
    var iconUrl: String
    var description: String
    var date: Date
    var type: String
    var numberOfLikes: Int64
    var numberOfCeleberations: Int64
    var numberOfLove: Int64
    var numberOfCare: Int64
    var numberOfLaugh: Int64
    var numberOfIdea: Int64
    var numberOfThinking: Int64
    var numberOfComments: Int64
    var numberOfShares: Int64
    let person: Person?
    let company: Company?
    
    public enum CodingKeys: String, CodingKey {
        case title
        case iconUrl
        case description
        case date
        case type
        case numberOfLikes = "number_of_likes"
        case numberOfCeleberations = "number_of_celeberations"
        case numberOfLove = "number_of_love"
        case numberOfCare = "number_of_care"
        case numberOfLaugh = "number_of_laugh"
        case numberOfIdea = "number_of_idea"
        case numberOfThinking = "number_of_thinking"
        case numberOfComments = "number_of_comments"
        case numberOfShares = "number_of_shares"
        case person
        case company
    }
}
