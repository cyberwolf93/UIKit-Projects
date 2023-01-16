//
//  UpdateUserLimitRequest.swift
//  NetworkCore
//
//  Created by Ahmed Mohiy on 27/10/2022.
//

import Foundation


public class UpdateUserCaloriesLimitRequest: BaseNetworkRequest {
    
    //MARK:- Variabels
    let calLimit: Int
    var api: String

    public init(calLimit: Int) {
        self.calLimit = calLimit
        self.api = "/update/\(calLimit)"
    }
    
    // MARK:- Implementation methods
    public func build(baseUrl: String, authToken: String) -> URLRequest? {
        var urlComponnets = URLComponents(string: baseUrl + self.api)
        
        guard let url = urlComponnets?.url else {
            
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HttpMethods.put.rawValue
        urlRequest.addValue(authToken, forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return urlRequest
    }
    
}
