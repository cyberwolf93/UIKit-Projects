//
//  DayFoodEntries.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 26/10/2022.
//

import Foundation

class DayFoodEntries {
    
    let date: String
    let timestamp: Int
    var entries = [FoodEntry]()
    
    init(date: String, timestamp: Int) {
        self.date = date
        self.timestamp = timestamp
    }
    
    func addEntry(entry: FoodEntry) {
        self.entries.append(entry)
    }
    
    
}
