//
//  SigninRequest.swift
//  NetworkCore
//
//  Created by Ahmed Mohiy on 22/10/2022.
//

import Foundation

public class SigninRequest: BaseNetworkRequest {
    
    //MARK:- Variabels
    let email: String
    let password: String
    var api: String

    public init(email: String, password: String) {
        self.email = email
        self.password = password
        self.api = "/signin"
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
            bodykeys.email.rawValue: self.email,
            bodykeys.password.rawValue: self.password
        ]
        
        let data = try? JSONSerialization.data(withJSONObject: json)
        return data
    }
    
    
    //MARK:- enum for holding request body keys
    enum bodykeys: String {
        case email = "email"
        case password = "password"
    }
    
}
