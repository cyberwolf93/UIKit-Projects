//
//  RaiseFunding.swift
//  linkedin_models
//
//  Created by Ahmed Mohiy on 23/01/2023.
//

import Foundation

public struct RaiseFunding: Funding {
    let numberOfRound: Int
    let date: Date
    let numberOfInvestors: Int
    let amount: Int
    let currency: String
}
