//
//  Identity.swift
//  linkedin_models
//
//  Created by Ahmed Mohiy on 23/01/2023.
//

import Foundation

public protocol Identity {
    var id: String { get }
    var name: String { get }
    var profileImageUrl: String { get }
    var coverImageUrl: String { get }
}
