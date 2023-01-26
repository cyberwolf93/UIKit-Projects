//
//  NetworkEngineProtocol.swift
//  NetworkCore
//
//  Created by Ahmed Mohiy on 22/10/2022.
//

import Foundation


public protocol NetworkEngineProtocol {
    var urlRequest: URLRequest? {get set}
    func excute(completion: @escaping (Result<Data, Error>) -> Void)
}
