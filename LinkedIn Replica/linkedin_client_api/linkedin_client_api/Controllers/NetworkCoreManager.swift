//
//  NetworkCoreManager.swift
//  NetworkCore
//
//  Created by Ahmed Mohiy on 22/10/2022.
//

import Foundation
struct BaseUrls {
    static let userBaseUrl = PlistManager.shared.base_url + "/user"
    static let foodEntry = PlistManager.shared.base_url + "/foodentry"
}

enum HttpMethods: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}

public class NetworkCoreManager {
    public var engine: NetworkEngineProtocol
    public var authToken: String
    
    
    public init(engine: NetworkEngineProtocol, authToken: String) {
        self.engine = engine
        self.authToken = authToken
    }
    
}
