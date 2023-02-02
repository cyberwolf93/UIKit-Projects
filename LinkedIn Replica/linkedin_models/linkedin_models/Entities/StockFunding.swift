//
//  StockFunding.swift
//  linkedin_models
//
//  Created by Ahmed Mohiy on 23/01/2023.
//

import Foundation

public struct StockFunding: Funding {
    public let type: FundingType
    public let sympol: String
    public let market: String
    public let lastPrice: Int
    public let currency: String
    public let gains: Int
    public let gainsPercentage: Int
    public let lastUpdate: Date
    public let openPrice: Int
    public let priceDayHigh: Int
    public let priceDayLow: Int
}
