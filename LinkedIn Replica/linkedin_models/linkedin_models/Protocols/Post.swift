//
//  Post.swift
//  linkedin_models
//
//  Created by Ahmed Mohiy on 23/01/2023.
//

import Foundation

public protocol Post {
    var title: String { get }
    var iconUrl: String { get }
    var description: String {get}
    var date: Date {get}
    var type: String {get} //TODO: CREAT ENUM image - video ....
    var numberOfLikes: Int64 {get}
    var numberOfCeleberations: Int64 {get}
    var numberOfLove: Int64 {get}
    var numberOfCare: Int64 {get}
    var numberOfLaugh: Int64 {get}
    var numberOfIdea: Int64 {get}
    var numberOfThinking: Int64 {get}
    var numberOfComments: Int64 {get}
    var numberOfShares: Int64 {get}
}
