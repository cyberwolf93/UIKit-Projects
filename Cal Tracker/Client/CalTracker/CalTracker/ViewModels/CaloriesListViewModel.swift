//
//  CaloriesListViewModel.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 25/10/2022.
//

import UIKit

class CaloriesListViewModel {
    
    let appPrefrences: AppPreferences
    var caloriesCountPerDate:[String:Int] = [:]
    var caloriesList: [CaloriesCount] = []
    var userCalLimit = 0
    
    init(appPrefrences: AppPreferences = AppPreferences.shared) {
        self.appPrefrences = appPrefrences
    }
    
    
    // Create dictionary holding the count for each day
    func prepareCaloriesCountDictionary(foodEntries: [FoodEntry]) {
        for entry in foodEntries {
            if caloriesCountPerDate[entry.date] == nil {
                caloriesCountPerDate[entry.date] = 0
            }
            
            caloriesCountPerDate[entry.date]! += entry.calValue
        }
        prepareCaloriesCountList()
    }
    
    
    // Create list for table view with all dates and each calories count
    func prepareCaloriesCountList() {
        for (dateString, count) in caloriesCountPerDate {
            if let date = Date.dateFrom(string: dateString, formate: "dd-MM-yyyy")  {
                let newDateString = Date.stringFromDate(date: date, formate: "MMM dd, yyyy")
                caloriesList.append(CaloriesCount(date: newDateString, count: count))
            }
        }
        
        caloriesList = caloriesList.sorted { item1, item2 in
            guard let date1 = Date.dateFrom(string: item1.date, formate: "MMM dd, yyyy") else {
                return true
            }
            
            guard let date2 = Date.dateFrom(string: item2.date, formate: "MMM dd, yyyy") else {
                return true
            }
            
            return date1 < date2
        }
    }
    
    
    // Return the text contains the calories count and the limit in same string
    func getCaloriesText(entry: CaloriesCount) -> NSMutableAttributedString {
        
        let dateAttributes = NSMutableAttributedString(string: "\(entry.date) - ", attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 20),
                                                                                                NSAttributedString.Key.foregroundColor:UIColor.mainTextReversed])
        let calValueAttributes = NSMutableAttributedString(string: "\(entry.count)",
                                                     attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 20),
                                                                  NSAttributedString.Key.foregroundColor: entry.count <= userCalLimit ? UIColor.greenColor : UIColor.darkRed2])
        let calLimitAttributes = NSMutableAttributedString(string: "/\(userCalLimit)",
                                                     attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15),
                                                                  NSAttributedString.Key.foregroundColor: UIColor.mainTextReversed])
        let combination = NSMutableAttributedString()
        combination.append(dateAttributes)
        combination.append(calValueAttributes)
        combination.append(calLimitAttributes)
        return combination
    
    }
    
    // Return image green if calories count less or equal to limit and red otherwise
    func getCaloriesRowImageView(calCount: Int)  -> UIImageView {
        guard let image = UIImage(systemName: calCount <= userCalLimit ?  "checkmark.seal.fill" : "exclamationmark.triangle")?
            .withTintColor(calCount <= userCalLimit ? .greenColor : .darkRed2, renderingMode: .alwaysOriginal) else {
            return UIImageView()
        }
        
        return UIImageView(image: image)
        
    }
}
