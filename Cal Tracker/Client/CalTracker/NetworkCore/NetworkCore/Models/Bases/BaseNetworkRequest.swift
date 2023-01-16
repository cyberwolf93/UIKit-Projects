//
//  BaseNetworkRequest.swift
//  NetworkCore
//
//  Created by Ahmed Mohiy on 16/01/2022.
//

import Foundation

protocol BaseNetworkRequest {
    var api: String {get set}
    func build(baseUrl: String, authToken: String) -> URLRequest?
}
