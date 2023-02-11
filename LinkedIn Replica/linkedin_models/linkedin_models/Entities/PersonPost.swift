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
    public var type: PostType
    public var numberOfLikes: Int64
    public var numberOfCeleberations: Int64
    public var numberOfLove: Int64
    public var numberOfSupport: Int64
    public var numberOfLaugh: Int64
    public var numberOfInsightful: Int64
    public var numberOfCurious: Int64
    public var numberOfComments: Int64
    public var numberOfShares: Int64
    public let person: PersonIdentity
    public let imageName: String
    
    public init(title: String, iconUrl: String, description: String, date: Date, type: PostType, numberOfLikes: Int64, numberOfCeleberations: Int64, numberOfLove: Int64, numberOfSupport: Int64, numberOfLaugh: Int64, numberOfInsightful: Int64, numberOfCurious: Int64, numberOfComments: Int64, numberOfShares: Int64, person: PersonIdentity, imageName: String) {
        self.title = title
        self.iconUrl = iconUrl
        self.description = description
        self.date = date
        self.type = type
        self.numberOfLikes = numberOfLikes
        self.numberOfCeleberations = numberOfCeleberations
        self.numberOfLove = numberOfLove
        self.numberOfSupport = numberOfSupport
        self.numberOfLaugh = numberOfLaugh
        self.numberOfInsightful = numberOfInsightful
        self.numberOfCurious = numberOfCurious
        self.numberOfComments = numberOfComments
        self.numberOfShares = numberOfShares
        self.person = person
        self.imageName = imageName
    }
}
