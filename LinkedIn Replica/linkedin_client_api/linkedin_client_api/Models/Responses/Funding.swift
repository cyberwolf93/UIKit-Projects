//
//  Funding.swift
//  linkedin_client_api
//
//  Created by Ahmed Mohiy on 26/01/2023.
//

import Foundation

struct Funding: Encodable {
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
    let numberOfRound: Int
    let lastRoundDate: Date
    let numberOfInvestors: Int
    let amount: Int
    let type: Int
    
    public enum CodingKeys: String, CodingKey {
        case sympol
        case market
        case lastPrice = "last_price"
        case currency
        case gains
        case gainsPercentage = "gains_percentage"
        case lastUpdate = "last_update"
        case openPrice = "open_price"
        case priceDayHigh = "price_day_high"
        case priceDayLow = "price_day_low"
        case numberOfRound = "number_of_round"
        case lastRoundDate = "last_round_date"
        case numberOfInvestors = "number_of_investors"
        case amount
        case type
    }
}

