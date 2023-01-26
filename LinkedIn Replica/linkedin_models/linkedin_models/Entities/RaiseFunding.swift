//
//  RaiseFunding.swift
//  linkedin_models
//
//  Created by Ahmed Mohiy on 23/01/2023.
//

import Foundation

public struct RaiseFunding: Funding {
    public let numberOfRound: Int
    public let date: Date
    public let numberOfInvestors: Int
    public let amount: Int
    public let currency: String
}
