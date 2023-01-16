//
//  PreTest.swift
//  CalTrackerTests
//
//  Created by Ahmed Mohiy on 27/10/2022.
//

import Foundation
@testable import CalTracker

class PreTestReportScreen {
    
    enum WeekID: CaseIterable {
        case lastWeek
        case weekBefore
    }
    
    var lastWeekRange: (Int,Int) = (0,0)
    var weekBeforeRange: (Int,Int) = (0,0)
    var weekEntriesDictionary = [WeekID: [String: DayFoodEntries]]()
    var lastWeekDayCaloriesDictionary = [String: DayCaloriesDataStructures]()
    
    func prepareWeekRangesForReportScreen() {
        
        
        // ex. Today = Wendsday Oct 26, 2022
        let today = Date().addingTimeInterval(0)
        // ex. lastWeekAsYesterday = Tuesday Oct 20, 2022
        let lastWeekAsYesterday = Date().addingTimeInterval(-(SEC_IN_MIN*MIN_IN_HOUR*HOUR_IN_DAY*6))
        // ex. lastWeekAsToday = Wendsday Oct 19, 2022
        let lastWeekAsToday = Date().addingTimeInterval(-(SEC_IN_MIN*MIN_IN_HOUR*HOUR_IN_DAY*7))
        // ex. weekBeforeAsLastWeekAsYesterday = Tuesday Oct 113, 2022
        let weekBeforeAsLastWeekAsYesterday = Date().addingTimeInterval(-(SEC_IN_MIN*MIN_IN_HOUR*HOUR_IN_DAY*13))
        
        weekBeforeRange = (Int(weekBeforeAsLastWeekAsYesterday.timeIntervalSince1970),
                           Int(lastWeekAsToday.timeIntervalSince1970))
        lastWeekRange = (Int(lastWeekAsYesterday.timeIntervalSince1970),
                         Int(today.timeIntervalSince1970))
        
        
        var day = 13
        // Create dictionary with each day in the last week with empty data if there is no food entries in that day
        var dictionary = [String: DayFoodEntries]()
        while (day >= 7) {
            let date = Date().addingTimeInterval(-(SEC_IN_MIN*MIN_IN_HOUR*HOUR_IN_DAY*Double(day)))
            let dateString = Date.stringFromDate(date: date, formate: "dd-MM-yyyy")
            dictionary[dateString] = DayFoodEntries(date: dateString, timestamp: Int(date.timeIntervalSince1970))
            day -= 1
        }
        weekEntriesDictionary[WeekID.weekBefore] = dictionary
        
        // Create dictionary with each day in the week before with empty data if there is no food entries in that day
        dictionary = [:]
        while (day >= 0) {
            let date = Date().addingTimeInterval(-(SEC_IN_MIN*MIN_IN_HOUR*HOUR_IN_DAY*Double(day)))
            let dateString = Date.stringFromDate(date: date, formate: "dd-MM-yyyy")
            dictionary[dateString] = DayFoodEntries(date: dateString, timestamp: Int(date.timeIntervalSince1970))
            
            // add empty calories entry for each date for last 7 days lastWeekDayCaloriesDictionary
            // this dictionary responsible for store total calories for each day
            lastWeekDayCaloriesDictionary[dateString] = DayCaloriesDataStructures(date: dateString, timestamp: Int(date.timeIntervalSince1970))
            day -= 1
        }
        weekEntriesDictionary[WeekID.lastWeek] = dictionary
        
    }
}
