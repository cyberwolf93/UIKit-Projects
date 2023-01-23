//
//  StockFunding.swift
//  linkedin_models
//
//  Created by Ahmed Mohiy on 23/01/2023.
//

import Foundation

public struct StockFunding: Funding {
    let sympol: String
    let market: String
    let lastPrice: Int
    let currency: String
    let gains: Int
    let gainsPercentage: Int
    let lastUpdate: Date
    let openPrice: Int
    let priceDayHigh: Int
    let priceDayLow: Int
}
