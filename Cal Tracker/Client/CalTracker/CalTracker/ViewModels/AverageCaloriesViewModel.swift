//
//  AverageCaloriesViewModel.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 27/10/2022.
//

import Foundation

class AverageCaloriesViewModel {
    
    
    func getUserAverage(from total: Int?) -> Int {
        guard let total else {
            return 0
        }
        
        return Int(Double(total) / 7)
    }
}
