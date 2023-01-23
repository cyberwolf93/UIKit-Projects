//
//  StringExtension.swift
//  linkedIn Replica
//
//  Created by Ahmed Mohiy on 16/01/2023.
//

import Foundation

extension String {
    func localizedString(with comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
}
