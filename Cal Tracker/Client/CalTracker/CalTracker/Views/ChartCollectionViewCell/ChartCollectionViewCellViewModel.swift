//
//  ChartCollectionViewCellViewModel.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 26/10/2022.
//

import Foundation


class ChartCollectionViewCellViewModel {
    
    let chartType: ChartType
    var pieChartDataEntries:[String: Int] = [:]
    var barChartDataEntries:[[DayFoodEntries]] = []
    var combinedChartDataEntries:[DayCaloriesDataStructures] = []
    
    
    init(chartType: ChartType, pieChartDataEntries: [String: Int] = [:], barChartDataEntries:[[DayFoodEntries]] = [], combinedChartDataEntries: [ DayCaloriesDataStructures] = []) {
        self.chartType = chartType
        self.pieChartDataEntries = pieChartDataEntries
        self.barChartDataEntries = barChartDataEntries
        self.combinedChartDataEntries = combinedChartDataEntries
    }
    
    
    //MARK: - Prepared and return data
    // return Pie data entries
    func getPieCharEntries() -> [(label: String, count: Int)] {
        return pieChartDataEntries.map { (key: String, value: Int) in
            return (label: key, count: value)
        }
    }
    
    func getBarCharEntriesGroup1() -> [(date: String, count: Int)] {
        if barChartDataEntries.count > 0 {
            return barChartDataEntries[0].map{ (date: $0.date, count: $0.entries.count) }
        }
        
        return []
    }
    
    func getBarCharEntriesGroup2() -> [(date: String, count: Int)] {
        if barChartDataEntries.count > 1 {
            return barChartDataEntries[1].map{ (date: $0.date, count: $0.entries.count) }
        }
        
        return []
    }
    
    func getCombinedChartData() -> ([(label: String, count: Int)], [Int]) {
        var userAverageList = [Int]()
        var caloriesList = [(label: String, count: Int)]()
        for entry in combinedChartDataEntries {
            userAverageList.append(entry.userCaloriesCount.count > 0 ? entry.totalCalories/entry.userCaloriesCount.count : 0 )
            caloriesList.append((label: entry.date, count: entry.totalCalories) )
        }
        
        return (caloriesList, userAverageList)
    }
    
    
    // MARK: - Enumeration
    enum ChartType {
        case pieChart
        case barChart
        case combinedChart
    }
}
