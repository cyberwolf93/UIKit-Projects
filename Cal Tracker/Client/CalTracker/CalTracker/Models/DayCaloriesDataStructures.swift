//
//  DayCaloriesTracker.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 26/10/2022.
//

import Foundation

class DayCaloriesDataStructures {
    
    let date: String
    let timestamp: Int
    var totalCalories: Int = 0
    var entries = [FoodEntry]()
    var userEntryDictionary = [String:[FoodEntry]]()
    var userCaloriesCount = [String: Int]()
    
    init(date: String, timestamp: Int) {
        self.date = date
        self.timestamp = timestamp
    }
    
    func addEntry(entry: FoodEntry) {
        self.entries.append(entry)
        self.totalCalories += entry.calValue
    }
    
    func addEntryForUser(id: String, entry: FoodEntry) {
        if userEntryDictionary[id] == nil  || userCaloriesCount[id] == nil {
            userEntryDictionary[id] = []
            userCaloriesCount[id] = 0
        }
        
        userEntryDictionary[id]?.append(entry)
        userCaloriesCount[id]! += entry.calValue
        
    }
    
    
    
}
