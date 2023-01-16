//
//  Models.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 27/10/2022.
//

import Foundation
@testable import CalTracker

struct Models {
    
    static let user1 = UserEntry(id: "1",
                                 name: "user1",
                                 email: "user1@test.com",
                                 token: "tokenUser1",
                                 isAdmin: true,
                                 calLimit: 2100)
    static let user2 = UserEntry(id: "2",
                                 name: "user2",
                                 email: "user2@test.com",
                                 token: "tokenUser2",
                                 isAdmin: false,
                                 calLimit: 2100)
    
    static let user3 = UserEntry(id: "3",
                                 name: "user3",
                                 email: "user3@test.com",
                                 token: "tokenUser3",
                                 isAdmin: false,
                                 calLimit: 2100)
    
    static let foodEntry1 = FoodEntry(id: "1",
                                      name: "food1",
                                      userId: Self.user2.id,
                                      thumbUrl: "thumb",
                                      date: "12-10-2022",
                                      time: "02:00",
                                      timestamp: 1665596791,
                                      calValue: 2100)
    
    static let foodEntry2 = FoodEntry(id: "2",
                                      name: "food2",
                                      userId: Self.user2.id,
                                      thumbUrl: "thumb",
                                      date: "09-10-2022",
                                      time: "02:00",
                                      timestamp: 1665337591,
                                      calValue: 2100)
    
    static let todayFoodEntry3 = FoodEntry(id: "3",
                                      name: "food3",
                                      userId: Self.user3.id,
                                      thumbUrl: "thumb",
                                      date: Self.getFromatedDateFrom(date: Date().addingTimeInterval(0)),
                                      time: "02:00",
                                      timestamp: Int(Date().addingTimeInterval(0).timeIntervalSince1970),
                                      calValue: 156)
    
    static let lastWeekFoodEntry4 = FoodEntry(id: "4",
                                      name: "food4",
                                      userId: Self.user3.id,
                                      thumbUrl: "thumb",
                                      date: Self.getFromatedDateFrom(date: Date().addingTimeInterval(-(SEC_IN_MIN*MIN_IN_HOUR*HOUR_IN_DAY*4))),
                                      time: "02:00",
                                      timestamp: Int(Date().addingTimeInterval(-(SEC_IN_MIN*MIN_IN_HOUR*HOUR_IN_DAY*4)).timeIntervalSince1970),
                                      calValue: 156)
    
    
    static let weekBeforeFoodEntry5 = FoodEntry(id: "5",
                                      name: "food5",
                                      userId: Self.user3.id,
                                      thumbUrl: "thumb",
                                      date: Self.getFromatedDateFrom(date: Date().addingTimeInterval(-(SEC_IN_MIN*MIN_IN_HOUR*HOUR_IN_DAY*11))),
                                      time: "02:00",
                                      timestamp: Int(Date().addingTimeInterval(-(SEC_IN_MIN*MIN_IN_HOUR*HOUR_IN_DAY*11)).timeIntervalSince1970),
                                      calValue: 156)
    
    
    static func getFromatedDateFrom(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: date)
    }
    
    
}
