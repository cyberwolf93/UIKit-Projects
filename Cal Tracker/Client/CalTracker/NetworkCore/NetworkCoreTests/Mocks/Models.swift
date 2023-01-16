//
//  Models.swift
//  NetworkCoreTests
//
//  Created by Ahmed Mohiy on 28/10/2022.
//

import Foundation
@testable import NetworkCore

struct Models {
    
    static let user1:[String: Any] = ["id": "1",
                      "name": "user1",
                      "email": "user1@test.com",
                      "token": "tokenUser1",
                      "isAdmin": true,
                                      "cal_limit": 2100]
    static let groupUsers:[[String: Any]] = [["id": "2",
                                              "name": "user2",
                                              "email": "user2@test.com",
                                              "token": "tokenUser2",
                                              "isAdmin": false,
                                              "cal_limit": 2100],
                                             ["id": "3",
                                              "name": "user3",
                                              "email": "user3@test.com",
                                              "token": "tokenUser3",
                                              "isAdmin": false,
                                              "cal_limit": 2100]]
    
    
    
    static let foodEntry1:[String: Any] = [
        "id": "1",
        "name": "food1",
        "userId": "1",
        "thumbUrl": "thumb",
        "date": "12-10-2022",
        "time": "02:00",
        "timestamp": 1665596791,
        "cal_value": 2100
    ]
    
    static let groupFoodEntries:[[String: Any]] = [
        [
            "id": "2",
            "name": "food2",
            "userId": "2",
            "thumbUrl": "thumb",
            "date": "12-10-2022",
            "time": "02:00",
            "timestamp": 1665596791,
            "cal_value": 2100
        ],
        [
            "id": "3",
            "name": "food3",
            "userId": "2",
            "thumbUrl": "thumb",
            "date": "12-10-2022",
            "time": "02:00",
            "timestamp": 1665596791,
            "cal_value": 2100
        ]]
    
    
}

