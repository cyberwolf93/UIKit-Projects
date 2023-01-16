//
//  DashboardViewModel.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 24/10/2022.
//

import UIKit
import NetworkCore

protocol DashboardViewModelDelegate: NSObjectProtocol {
    func fetchDidSucceeded()
    func fetchDidFailed(error: Error?)
    func deleteItemDidSucceded()
    func deleteItemDidFailed(error: Error?)
}

class DashboardViewModel {
    
    // MARK: Apis handlers
    let foodEntryCoreManager: FoodEntryCoreManager
    let userCoreManager: UserCoreManager
    let appPrefrences: AppPreferences
    
    // MARK: Models
    private var foodEntries: [FoodEntry] = []
    private var filteredEntries: [FoodEntry] = []
    private var userList: [UserEntry] = []
    
    // MARK: Variables
    weak var delegate:DashboardViewModelDelegate?
    
    
    // MARK: Filters Variables
    private var selectedUser: UserEntry?
    var filteredFromDate = ""
    var filteredToDate = ""
    private var filterFrom: Int = 0 {
        didSet {
            if filterFrom > 0 {
                filteredFromDate = Date.stringFromDate(date: Date(timeIntervalSince1970: TimeInterval(filterFrom)) , formate: "dd-MM-yyyy")
                return
            }
            
            filteredFromDate = ""
        }
    }
    private var filterTo: Int = 0 {
        didSet {
            if filterTo > 0 {
                filteredToDate = Date.stringFromDate(date: Date(timeIntervalSince1970: TimeInterval(filterTo)) , formate: "dd-MM-yyyy")
                return
            }
            
            filteredToDate = ""
        }
    }
    
    
    // MARK: - Initialization
    init(foodEntryCoreManager: FoodEntryCoreManager, userCoreManager: UserCoreManager, appPrefrences: AppPreferences = AppPreferences.shared) {
        self.foodEntryCoreManager = foodEntryCoreManager
        self.userCoreManager = userCoreManager
        self.appPrefrences = appPrefrences
    }
    
    // MARK: - Fetching data
    //Get all food entries
    func fetchAllEntries() {
        guard  let user = appPrefrences.getUser() else {
            return
        }
        
        if user.isAdmin {
            fetchEntries(With: "")
            return
        }
        fetchEntries(With: user.id)
    }
    
    //Fetch All users for admin only
    private func fetchAllUsers() {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            let request = FetchAllUsersRequest()
            self?.userCoreManager.fetchAllUsers(request: request) { result in
                switch(result) {
                case .success(let users):
                    DispatchQueue.synchronized(self?.userList as? [UserEntry]) {
                        self?.userList = []
                        for user in users {
                            self?.userList.append(UserEntry(from: user))
                        }
                    }
                    break
                case .failure(_):
                    break
                }
                self?.applyFilter()
                
            }
        }
    }
    
    // Get all food with id or empty id for admin
    private func fetchEntries(With id: String) {
        let requst = GetFoodEntriesRequest(userId: id)
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.foodEntryCoreManager.getEntries(request: requst, completion: { result in
                switch(result) {
                case .success(let entries):
                    self?.foodEntries = []
                    for entry in entries {
                        self?.foodEntries.append(FoodEntry(from: entry))
                    }
                    if let self, self.userIsAdmin() {
                        self.fetchAllUsers()
                    } else {
                        self?.applyFilter()
                    }
                case .failure(let error):
                    self?.delegate?.fetchDidFailed(error: error)
                }
            })
        }
    }
    
    
    // MARK: - Delete data remotley and locally
    // Delete Food entry with id
    func deleteFoodEntry(with foodEntry: FoodEntry) {
        let request = DeleteFoodEntryRequest(entryId: foodEntry.id, userId: foodEntry.userId)
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.foodEntryCoreManager.deleteFoodEntry(request: request) { result in
                switch(result) {
                case .success(_):
                    self?.deleteItemFromFoodEntries(id: foodEntry.id)
                case .failure(let error):
                    self?.delegate?.deleteItemDidFailed(error: error)
                }
            }
        }
    }
    
    private func deleteItemFromFoodEntries(id: String) {
        DispatchQueue.synchronized(self.foodEntries) { [weak self] in
            self?.foodEntries.removeAll(where: { $0.id == id })
        }
        self.delegate?.deleteItemDidSucceded()
    }
    
    
    // MARK: - Retrieving Data for UI view
    //return filtered foodEntries
    func getFilterdFoodEntries() -> [FoodEntry] {
        return DispatchQueue.synchronized(self.filteredEntries) {
            return filteredEntries
        }
    }
    
    
    // Return number of calories
    func numberOfCaloriesOfToday() -> Int {
        var count = 0
        let dateString = Date.stringFromDate(date: Date().addingTimeInterval(0) , formate: "dd-MM-yyyy")
        for item in foodEntries {
            if dateString == item.date {
                count += item.calValue
            }
            
        }
        
        return count
    }
    
    //calories limit
    func getCaloriesLimit() -> Int {
        if let user = appPrefrences.getUser() {
            return user.calLimit
        }
        
        return 0
    }
    
    
    // Check if the user hase the admin role
    func userIsAdmin() -> Bool {
        guard let user = appPrefrences.getUser() else {
            return false
        }
        
        return user.isAdmin
    }
    
    func getUserIfNormal() -> UserEntry? {
        guard !userIsAdmin() else {
            return nil
        }
        
        guard let user = appPrefrences.getUser() else {
            return nil
        }
        
        return UserEntry(from: user)
    }
    
    // Return all users for admin user
    func getAllUsers() -> [UserEntry] {
        return DispatchQueue.synchronized(self.userList) {
            return userList
        }
    }
    
    func getSelectedUser() -> UserEntry? {
        return selectedUser
    }
    
    // check if filter is on by date
    func isFilterDateOn() -> Bool{
        return self.filterFrom != 0 && self.filterTo != 0
    }
    
    func isFilterUserOn() -> Bool {
        return selectedUser != nil
    }
    
    func getFoodSortedList() -> [FoodEntry] {
        return foodEntries.sorted(by: { $0.timestamp < $1.timestamp })
    }
    
    func getSelectedUserList() -> [FoodEntry] {
        var list:[FoodEntry] = []
        for entry in foodEntries {
            if let user = selectedUser, user.id == entry.userId {
                list.append(entry)
            }
        }
        
        return list.sorted(by: { $0.timestamp < $1.timestamp })
    }
    
    // MARK: - Filtering Data for UI view
    
    //MARK: Reset data
    // Reset User filter to list all food entries for all users
    func resetUserFilter() {
        self.selectedUser = nil
        self.applyFilter()
    }
    
    
    // Reset Date filter to list all food entries for dates
    func resetDateFilter() {
        self.filterFrom = 0
        self.filterTo = 0
        self.applyFilter()
    }
    
    
    // MARK: Set data with new values
    // Set selected user for filter food entries with it
    func setSelectedUser(user: UserEntry) {
        self.selectedUser = user
    }
    
    // Set filter date from value
    func setFilterDateFrom(_ value: String) {
        if let date = Date.dateFrom(string: value, formate: "dd-MM-yyyy") {
            filterFrom = Int(date.timeIntervalSince1970)
        }
        
    }
    
    // Set filter date to value
    func setFilterDateTo(_ value: String) {
        if let date = Date.dateFrom(string: value, formate: "dd-MM-yyyy") {
            filterTo = Int(date.timeIntervalSince1970)
        }
    }
    
    
    
    
    
    
    // MARK: Get data used in filteration
    // Function check if food entry created date is in the filtered range
    // if there is no filter range this function return true
    func checkFoodEntryInRange(timeStamp: Int) -> Bool{
        if  filterFrom == 0 || filterTo == 0 {
            return true
        }
        
        if timeStamp >= filterFrom && timeStamp <= filterTo {
            return true
        }
        
        return false
    }
    
    // Get filter date range
    func getFilterDateRange() -> (Int, Int) {
        return (filterFrom, filterTo)
    }
    
    //return all foodEntries
    private func getAllFoodEntries() -> [FoodEntry] {
        return DispatchQueue.synchronized(self.foodEntries) {
            return foodEntries
        }
    }
    
    
    
    // Function apply Filter on food Entries
    func applyFilter() {
        let entries = self.getAllFoodEntries()
        DispatchQueue.synchronized(self.filteredEntries) { [weak self] in
            self?.filteredEntries = []
            for entry in entries {
                // Continue and ignore this entry
                // if food entry does not belog to selcted user to be filtered with
                if let selectedUser,  selectedUser.id != entry.userId{
                    continue
                }
                
                // Continue and ignore this entry
                // if this entry created out of the filtered range
                if !(self?.checkFoodEntryInRange(timeStamp: entry.timestamp) ?? true) {
                    continue
                }
                
                // Appened the entry matching the filters  criteria
                self?.filteredEntries.append(entry)
            }
        }
        self.delegate?.fetchDidSucceeded()
    }
    
    
    // MARK: - Retrieving helpers UI
    // return button filter date Image
    func getFilterByDateImage() -> UIImage? {
        if isFilterDateOn() {
            return UIImage(systemName: "slider.horizontal.3")?.withTintColor(.darkRed2, renderingMode: .alwaysOriginal)
        }
        
        return UIImage(systemName: "slider.horizontal.3")?.withTintColor(.lightBlue1, renderingMode: .alwaysOriginal)
    }
    
    // return button filter by user Image
    func getFilterByUserImage() -> UIImage? {
        if self.isFilterUserOn() {
            return UIImage(systemName: "person.fill")?.withTintColor(.darkRed2, renderingMode: .alwaysOriginal)
        }
        
        return UIImage(systemName: "person.fill")?.withTintColor(.lightBlue1, renderingMode: .alwaysOriginal)
    }
    
    //return collection view tilte
    func getCollectionViewTitle() -> String {
        if self.isFilterDateOn() {
            return "\(filteredFromDate) to \(filteredToDate)"
        }
        
        return String.localizedString(with: "all_food_entries")
    }
    
    
}
