//
//  NetworkEngineError.swift
//  NetworkCore
//
//  Created by Ahmed Mohiy on 22/10/2022.
//

import Foundation

public enum NetworkEngineError: Error {
    case invalidData
    case invalidUrl
    case badRequest
    case unAuthorized
    case notFound
    case serverError
}


extension NetworkEngineError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return String.localizedString(with: "network_core_invalid_url")
        case .invalidData:
            return String.localizedString(with: "network_core_nod_data")
        case .badRequest:
            return String.localizedString(with: "network_core_bad_request")
        case .serverError:
            return String.localizedString(with: "network_core_server_error")
        case .unAuthorized:
            return String.localizedString(with: "network_core_server_unauthorized")
        case .notFound:
            return String.localizedString(with: "network_core_server_not_found")
        }
    }
}
