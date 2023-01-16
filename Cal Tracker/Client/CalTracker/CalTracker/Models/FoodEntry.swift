//
//  FoodEntry.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 24/10/2022.
//

import Foundation
import NetworkCore

struct FoodEntry {
    public let id: String
    public let name: String
    public let userId: String
    public let thumbUrl: String
    public let date: String
    public let time: String
    public let timestamp: Int
    public let calValue: Int
    
    init(id: String, name: String, userId: String, thumbUrl: String, date: String, time: String, timestamp: Int, calValue: Int) {
        self.id = id
        self.name = name
        self.userId = userId
        self.thumbUrl = thumbUrl
        self.date = date
        self.time = time
        self.timestamp = timestamp
        self.calValue = calValue
    }
    
    init(from fdRespons: FoodEntryResponse) {
        id = fdRespons.id
        name = fdRespons.name
        userId = fdRespons.userId
        thumbUrl = fdRespons.thumbUrl
        date = fdRespons.date
        time = fdRespons.time
        timestamp = fdRespons.timestamp
        calValue = fdRespons.calValue
    }
}
