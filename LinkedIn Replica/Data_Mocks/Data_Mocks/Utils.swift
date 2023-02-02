//
//  Utils.swift
//  Data_Mocks
//
//  Created by Ahmed Mohiy on 26/01/2023.
//

import Foundation

extension Date {
    static func getDateFrom(date: String, with formate: String = "dd/MM/yyyy") -> Date {
        let formated = DateFormatter()
        formated.dateFormat = formate
        return formated.date(from: date)!
    }
}
