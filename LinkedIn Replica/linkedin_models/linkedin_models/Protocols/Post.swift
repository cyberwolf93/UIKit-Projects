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
    var type: PostType {get}
    var numberOfLikes: Int64 {get}
    var numberOfCeleberations: Int64 {get}
    var numberOfLove: Int64 {get}
    var numberOfSupport: Int64 {get}
    var numberOfLaugh: Int64 {get}
    var numberOfInsightful: Int64 {get}
    var numberOfCurious: Int64 {get}
    var numberOfComments: Int64 {get}
    var numberOfShares: Int64 {get}
    var imageName: String {get}
}
