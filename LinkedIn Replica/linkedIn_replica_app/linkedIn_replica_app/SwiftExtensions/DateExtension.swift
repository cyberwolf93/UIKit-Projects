//
//  DateExtension.swift
//  linkedIn Replica
//
//  Created by Ahmed Mohiy on 02/02/2023.
//

import Foundation

extension Date {
    static let NUMBER_OF_SECONDS_IN_YEAR:Double = 31_536_000
    static let NUMBER_OF_SECONDS_IN_MONTH:Double = 2_592_000
    static let NUMBER_OF_SECONDS_IN_WEEK:Double = 604_800
    static let NUMBER_OF_SECONDS_IN_DAY:Double = 86_400
    static let NUMBER_OF_SECONDS_IN_HOUR:Double = 3600
    static let NUMBER_OF_SECONDS_IN_MINUTES:Double = 60
    
    
    func dateForPost() -> String {
        let dateNowInSecond = Date.now.timeIntervalSince1970
        let diffrence = dateNowInSecond - self.timeIntervalSince1970
        // return amount in years
        if diffrence >= Self.NUMBER_OF_SECONDS_IN_YEAR {
            return "\(Int(diffrence/Self.NUMBER_OF_SECONDS_IN_YEAR)) yr"
        }
        
        // return amount in months
        if diffrence >=  Self.NUMBER_OF_SECONDS_IN_MONTH {
            return "\(Int(diffrence/Self.NUMBER_OF_SECONDS_IN_MONTH)) mo"
        }
        
        // return amount in weeks
        if diffrence >=  Self.NUMBER_OF_SECONDS_IN_WEEK {
            return "\(Int(diffrence/Self.NUMBER_OF_SECONDS_IN_WEEK)) w"
        }
        
        // return amount in days
        if diffrence >=  Self.NUMBER_OF_SECONDS_IN_DAY {
            return "\(Int(diffrence/Self.NUMBER_OF_SECONDS_IN_DAY)) d"
        }
        
        // return amount in hours
        if diffrence >=  Self.NUMBER_OF_SECONDS_IN_HOUR {
            return "\(Int(diffrence/Self.NUMBER_OF_SECONDS_IN_HOUR)) hr"
        }
        
        // return amount in mintes
        if diffrence >=  Self.NUMBER_OF_SECONDS_IN_MINUTES {
            return "\(Int(diffrence/Self.NUMBER_OF_SECONDS_IN_MINUTES)) m"
        }
        
        return "1 m"
    }
    
    static func getDateFrom(date: String, with formate: String = "dd/MM/yyyy") -> Date {
        let formated = DateFormatter()
        formated.dateFormat = formate
        return formated.date(from: date)!
    }
}
