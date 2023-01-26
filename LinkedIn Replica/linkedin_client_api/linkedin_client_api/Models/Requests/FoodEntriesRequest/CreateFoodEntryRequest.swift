//
//  CreateFoodEntry.swift
//  NetworkCore
//
//  Created by Ahmed Mohiy on 22/10/2022.
//

import Foundation

public class CreateFoodEntryRequest: BaseNetworkRequest {
    
    //MARK:- Variabels
    let userId: String
    let name: String
    let date: String
    let time: String
    let timestamp: Int
    let calValue: Int
    var api: String
    
    public init(userId: String, name: String, date: String, time: String, timestamp: Int, calValue: Int) {
        self.userId = userId
        self.name = name
        self.date = date
        self.time = time
        self.timestamp = timestamp
        self.calValue = calValue
        self.api = "/create"
        
    }
    
    
    // MARK:- Implementation methods
    public func build(baseUrl: String, authToken: String) -> URLRequest? {
        var urlComponnets = URLComponents(string: baseUrl + self.api)
        
        guard let url = urlComponnets?.url else {
            
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HttpMethods.post.rawValue
        urlRequest.addValue(authToken, forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let jsonData = self.buildRequestBody() else {
            return nil
        }
        
        urlRequest.httpBody = jsonData
        
        return urlRequest
    }
    
    // Helper methods
    private func buildRequestBody() -> Data? {
        let json: [String: Any] = [
            bodykeys.userId.rawValue: self.userId,
            bodykeys.name.rawValue: self.name,
            bodykeys.date.rawValue: self.date,
            bodykeys.time.rawValue: self.time,
            bodykeys.timestamp.rawValue: self.timestamp,
            bodykeys.calValue.rawValue: self.calValue
        ]
        
        let data = try? JSONSerialization.data(withJSONObject: json)
        return data
    }
    
    
    //MARK:- enum for holding request body keys
    enum bodykeys: String {
        case userId = "user_id"
        case name = "name"
        case date = "date"
        case time = "time"
        case timestamp = "timestamp"
        case calValue = "cal_value"
    }
    
}


