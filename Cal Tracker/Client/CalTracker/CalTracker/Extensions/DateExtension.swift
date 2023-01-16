//
//  DateExtension.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 25/10/2022.
//

import Foundation

extension Date {
    
    static func dateFrom(string: String, formate: String)  -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        return dateFormatter.date(from: string)
    }
    
    static func stringFromDate(date: Date, formate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        return dateFormatter.string(from: date)
    }
}
