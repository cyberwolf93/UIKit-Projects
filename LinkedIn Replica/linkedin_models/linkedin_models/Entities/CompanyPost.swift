//
//  CompanyPost.swift
//  linkedin_models
//
//  Created by Ahmed Mohiy on 23/01/2023.
//

import Foundation

public struct CompanyPost: Post {
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
    public let company: CompanyIdentity
    public let imageName: String
}
