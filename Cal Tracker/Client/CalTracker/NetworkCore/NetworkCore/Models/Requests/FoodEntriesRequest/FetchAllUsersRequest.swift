//
//  fetchAllUsersRequest.swift
//  NetworkCore
//
//  Created by Ahmed Mohiy on 25/10/2022.
//

import Foundation

public class FetchAllUsersRequest: BaseNetworkRequest {
    
    var api: String
    
    public init() {
        self.api = "/get"
    }
    
    // MARK:- Implementation methods
    public func build(baseUrl: String, authToken: String) -> URLRequest? {
        var urlComponnets = URLComponents(string: baseUrl + self.api)
        
        guard let url = urlComponnets?.url else {
            
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HttpMethods.get.rawValue
        urlRequest.addValue(authToken, forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        return urlRequest
    }
    
}

