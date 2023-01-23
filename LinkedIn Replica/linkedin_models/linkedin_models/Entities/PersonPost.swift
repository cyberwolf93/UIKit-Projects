//
//  PersonPost.swift
//  linkedin_models
//
//  Created by Ahmed Mohiy on 23/01/2023.
//

import Foundation

public struct PersonPost: Post {
    public var title: String
    public var iconUrl: String
    public var description: String
    public var date: Date
    public var type: String
    public var numberOfLikes: Int64
    public var numberOfCeleberations: Int64
    public var numberOfLove: Int64
    public var numberOfCare: Int64
    public var numberOfLaugh: Int64
    public var numberOfIdea: Int64
    public var numberOfThinking: Int64
    public var numberOfComments: Int64
    public var numberOfShares: Int64
    let person: PersonIdentity
}
