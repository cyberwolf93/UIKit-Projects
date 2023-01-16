//
//  ReportViewController.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 26/10/2022.
//

import Foundation
import NetworkCore

let SEC_IN_MIN:Double = 60
let MIN_IN_HOUR:Double = 60
let HOUR_IN_DAY:Double = 24


protocol ReportViewModelDelegate: NSObjectProtocol {
    func reportDataIsReady()
    func failedToPrepareReportData()
}

class ReportViewModel {
    
    // MARK: - Core dependencies
    let userCoreManager: UserCoreManager
    let foodCoremanager: FoodEntryCoreManager
    
    //MARK: Variables
    var lastWeekRange: (Int,Int) = (0,0)
    var weekBeforeRange: (Int,Int) = (0,0)
    
    //MARK: Data structures
    var usersList = [UserEntry]()
    var totalCalPerUserLastWeek = [String: Int]()
    var allFoodEntries = [FoodEntry]()
    var weekEntriesDictionary = [WeekID: [String: DayFoodEntries]]()
    var weekEntriesTotal = [WeekID: Int]()
    var lastWeekDayCaloriesDictionary = [String: DayCaloriesDataStructures]()
    var collectionViewList: [[Row]] = []
    
    //MARK: Delegates
    weak var delegate: ReportViewModelDelegate?
    
    
    //MARK: - Initialization
    init(userCoreManager: UserCoreManager, foodCoremanager: FoodEntryCoreManager) {
        self.userCoreManager = userCoreManager
        self.foodCoremanager = foodCoremanager
    }
    
    func initViewModel() {
        prepareWeeksRanges()
        fetchAllUserData()
    }
    
    
    // MARK: - Prepare data
    func prepareWeeksRanges() {
        // ex. Today = Wendsday Oct 26, 2022
        let today = Date().addingTimeInterval(0)
        // ex. lastWeekAsYesterday = Tuesday Oct 20, 2022
        let lastWeekAsYesterday = Date().addingTimeInterval(-(SEC_IN_MIN*MIN_IN_HOUR*HOUR_IN_DAY*6))
        // ex. lastWeekAsToday = Wendsday Oct 19, 2022
        let lastWeekAsToday = Date().addingTimeInterval(-(SEC_IN_MIN*MIN_IN_HOUR*HOUR_IN_DAY*7))
        // ex. weekBeforeAsLastWeekAsYesterday = Tuesday Oct 113, 2022
        let weekBeforeAsLastWeekAsYesterday = Date().addingTimeInterval(-(SEC_IN_MIN*MIN_IN_HOUR*HOUR_IN_DAY*13))
        
        weekBeforeRange = (Int(weekBeforeAsLastWeekAsYesterday.timeIntervalSince1970),
                           Int(lastWeekAsToday.timeIntervalSince1970))
        lastWeekRange = (Int(lastWeekAsYesterday.timeIntervalSince1970),
                         Int(today.timeIntervalSince1970))
        
        
        var day = 13
        // Create dictionary with each day in the last week with empty data if there is no food entries in that day
        var dictionary = [String: DayFoodEntries]()
        while (day >= 7) {
            let date = Date().addingTimeInterval(-(SEC_IN_MIN*MIN_IN_HOUR*HOUR_IN_DAY*Double(day)))
            let dateString = Date.stringFromDate(date: date, formate: "dd-MM-yyyy")
            dictionary[dateString] = DayFoodEntries(date: dateString, timestamp: Int(date.timeIntervalSince1970))
            day -= 1
        }
        weekEntriesDictionary[WeekID.weekBefore] = dictionary
        
        // Create dictionary with each day in the week before with empty data if there is no food entries in that day
        dictionary = [:]
        while (day >= 0) {
            let date = Date().addingTimeInterval(-(SEC_IN_MIN*MIN_IN_HOUR*HOUR_IN_DAY*Double(day)))
            let dateString = Date.stringFromDate(date: date, formate: "dd-MM-yyyy")
            dictionary[dateString] = DayFoodEntries(date: dateString, timestamp: Int(date.timeIntervalSince1970))
            
            // add empty calories entry for each date for last 7 days lastWeekDayCaloriesDictionary
            // this dictionary responsible for store total calories for each day
            lastWeekDayCaloriesDictionary[dateString] = DayCaloriesDataStructures(date: dateString, timestamp: Int(date.timeIntervalSince1970))
            day -= 1
        }
        weekEntriesDictionary[WeekID.lastWeek] = dictionary

    }
    
    func prepareCollectionViewData() {
        collectionViewList = [
            [.detailsRow, .pieChartRow],
            [.detailsRow, .barChartRow],
            [.detailsRow, .combinedChartRow]
        ]
    }
    
    //MARK: - Fetching Data
    //Fetch All users for admin only
    private func fetchAllUserData() {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            let request = FetchAllUsersRequest()
            self?.userCoreManager.fetchAllUsers(request: request) { result in
                switch(result) {
                case .success(let users):
                    self?.usersList = []
                    for user in users {
                        self?.usersList.append( UserEntry(from: user))
                    }
                    self?.fetchFoodEntries()
                    break
                case .failure(_):
                    self?.delegate?.failedToPrepareReportData()
                    break
                }
                
                
            }
        }
    }
    
    // Fetch all FoodEntries
    private func fetchFoodEntries() {
        let requst = GetFoodEntriesRequest(userId: "")
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.foodCoremanager.getEntries(request: requst, completion: { result in
                switch(result) {
                case .success(let entries):
                    self?.allFoodEntries = []
                    for entry in entries {
                        self?.allFoodEntries.append(FoodEntry(from: entry))
                    }
                    self?.prepareReportData()
                case .failure(_):
                    self?.delegate?.failedToPrepareReportData()
                    break
                }
            })
        }
            
        
    }
    
    // MARK: - Processing methods
    func prepareReportData() {
        for foodEntry in allFoodEntries {
            let lastWeekCheck = inLastWeekRange(timestamp: foodEntry.timestamp)
            let weekBeforeCheck = inWeekBeforeRange(timestamp: foodEntry.timestamp)
            
            // handle lastWeekDayCaloriesDictionary for get calories analytics
            handleCaloriesEntryAverageAnaylics(lastWeekCheck: lastWeekCheck, entry: foodEntry)
            
            //handle number of entries array for week id
            if lastWeekCheck {
                handleEntriesNumberAnalytics(weekId: WeekID.lastWeek, entry: foodEntry)
                
                //increase total caloriesfor  the owner of this entry
                totalCalPerUserLastWeek[foodEntry.userId] = (totalCalPerUserLastWeek[foodEntry.userId] ?? 0) + foodEntry.calValue
            } else if weekBeforeCheck {
                handleEntriesNumberAnalytics(weekId: WeekID.weekBefore, entry: foodEntry)
            }
            
           
            
        }
        
        self.prepareCollectionViewData()
        self.delegate?.reportDataIsReady()
        
    }
    
    // MARK: - Helper methods
    func inLastWeekRange(timestamp: Int) -> Bool {
        if timestamp >= lastWeekRange.0 && timestamp <= lastWeekRange.1 {
            return true
        }
        
        return false
    }
    
    func inWeekBeforeRange(timestamp: Int) -> Bool {
        if timestamp >= weekBeforeRange.0 && timestamp <= weekBeforeRange.1 {
            return true
        }
        
        return false
    }
    
    func handleCaloriesEntryAverageAnaylics(lastWeekCheck: Bool, entry: FoodEntry) {
        guard lastWeekCheck else {
            return
        }
        
        // Get the calories data structures
        let dayCaloriesDataStructures = self.lastWeekDayCaloriesDictionary[entry.date] ?? DayCaloriesDataStructures(date: entry.date,
                                                                                                                  timestamp: entry.timestamp)
        
        dayCaloriesDataStructures.addEntry(entry: entry)
        dayCaloriesDataStructures.addEntryForUser(id: entry.userId, entry: entry)
        self.lastWeekDayCaloriesDictionary[entry.date] = dayCaloriesDataStructures
    }
    
    func handleEntriesNumberAnalytics(weekId: WeekID, entry: FoodEntry) {
        // Get 7 days of food entries in ad dictionary with a key for each day
        var numberOfEntriesList = self.weekEntriesDictionary[weekId] ?? [:]
        // Get the specific day for current entry or create new one if it does not exist
        let dayFoodEntries = numberOfEntriesList[entry.date] ?? DayFoodEntries(date: entry.date,
                                                                             timestamp: entry.timestamp)
        dayFoodEntries.addEntry(entry: entry)
        numberOfEntriesList[entry.date] = dayFoodEntries
        self.weekEntriesDictionary[weekId] = numberOfEntriesList
        
        // handle Week all entries count
        var weekAllEntriesCount = self.weekEntriesTotal[weekId] ?? 0
        weekAllEntriesCount += 1
        self.weekEntriesTotal[weekId] = weekAllEntriesCount
        
    }
    
    //MARK: - Helper methods for UI View
    func weekLabel(by weekId: WeekID) -> String {
        switch(weekId) {
        case .lastWeek:
            return String.localizedString(with: "last_week")
        case .weekBefore:
            return String.localizedString(with: "week_before")
        }
        
    }
    
    func getPieChartData() -> [String: Int] {
        var dictionary = [String: Int]()
        for weekId in Self.WeekID.allCases {
            if let count = self.weekEntriesTotal[weekId] {
                dictionary[self.weekLabel(by: weekId)] = count
            }
        }
        
        return dictionary
    }
    
    func getLastWeekEntriesNumberLabel() -> String {
        return "\(String.localizedString(with: "last_week_entries_count")): \(weekEntriesTotal[WeekID.lastWeek] ?? 0) "
    }
    func getWeekBeforeEntriesNumberLabel() -> String {
        return "\(String.localizedString(with: "week_before_entries_count")): \(weekEntriesTotal[WeekID.weekBefore] ?? 0) "
    }
    
    func getBarChartData() -> [[DayFoodEntries]] {
        var list2D = [[DayFoodEntries]]()
        if let lastWeek = weekEntriesDictionary[WeekID.lastWeek] {
            var list = [DayFoodEntries]()
            for (_, value) in lastWeek {
                list.append(value)
            }
            list2D.append(list.sorted(by: {$0.timestamp < $1.timestamp}))
        }
        
        if let weekBefore = weekEntriesDictionary[WeekID.weekBefore] {
            var list = [DayFoodEntries]()
            for (_, value) in weekBefore {
                list.append(value)
            }
            list2D.append(list.sorted(by: {$0.timestamp < $1.timestamp}))
        }
        
        return list2D
    }
    
    func getCombinedBarChart() -> [DayCaloriesDataStructures] {
        var list = [DayCaloriesDataStructures]()
        for (_ , value) in lastWeekDayCaloriesDictionary {
            list.append(value)
        }
        
        return list.sorted(by: { $0.timestamp < $1.timestamp})
    }
    
    func getAverageCaloriesPerUserLabel() -> Int {
        var sum = 0
        _ = self.lastWeekDayCaloriesDictionary.map { (_ , value) in
            sum += value.totalCalories
        }
        print("count : \(sum)")
        return self.usersList.count > 0 ? sum / self.usersList.count : 0
    }
    
    
    // MARK: - Enumerations
    enum WeekID: CaseIterable {
        case lastWeek
        case weekBefore
    }
    
    enum Section: Int {
        case entriesCountPieChart = 0
        case entriesCountBarChart = 1
        case entriesCountCombinedChart = 2
    }
    
    enum Row {
        case detailsRow
        case pieChartRow
        case barChartRow
        case combinedChartRow
    }
    
}
