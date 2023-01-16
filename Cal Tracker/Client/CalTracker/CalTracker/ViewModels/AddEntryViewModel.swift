//
//  AddEntryViewModel.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 24/10/2022.
//

import UIKit
import NetworkCore

protocol AddEntryViewModelDelegate: NSObjectProtocol {
    func addEntryDidSucceeded()
    func addEntryDidFailed(error: Error?)
}

class AddEntryViewModel {
    
    // MARK: - Variables
    let foodEntryCoreManager: FoodEntryCoreManager
    weak var delegate: AddEntryViewModelDelegate?
    var screenMode: AddFoodScreenMode = .add
    
    // MARK: - Initialization
    init(foodEntryCoreManager: FoodEntryCoreManager) {
        self.foodEntryCoreManager = foodEntryCoreManager
    }
    
    
    // MARK: - Fetching And uplaoding Data
    func saveFoodEntry(foodEntry: FoodEntry, image: Data, oldEntry: FoodEntry?) {
        switch(screenMode) {
        case .add:
            self.addFoodEntry(foodEntry: foodEntry, image: image)
        case .edit:
            if let oldEntry {
                self.updateFoodEntry(foodEntry: foodEntry, image: image, oldEntry: oldEntry)
            } else {
                self.delegate?.addEntryDidFailed(error: nil)
            }
            
        }
    }
    
    //ADD New entry
    private func addFoodEntry(foodEntry: FoodEntry, image: Data) {
        let request = CreateFoodEntryRequest(userId: foodEntry.userId,
                                             name: foodEntry.name,
                                             date: foodEntry.date,
                                             time: foodEntry.time,
                                             timestamp: foodEntry.timestamp,
                                             calValue: foodEntry.calValue)
        
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.foodEntryCoreManager.createFoodEntry(request: request, completion: { result in
                switch (result) {
                case .success(let foodEntry):
                    self?.uploadImage(entryId: foodEntry.id, image: image)
                case .failure(let error):
                    self?.delegate?.addEntryDidFailed(error: error)
                }
            })
        }
        
    }
    
    //Add update current food entry
    private func updateFoodEntry(foodEntry: FoodEntry, image: Data, oldEntry: FoodEntry) {
        let request = UpdateFoodEntryRequest(entryId: oldEntry.id,
                                             userId: oldEntry.userId, // Always use userId inside oldFoodEntry
                                             name: foodEntry.name,
                                             calValue: foodEntry.calValue)
        
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.foodEntryCoreManager.updateFoodEntry(request: request, completion: { result in
                switch (result) {
                case .success(let foodEntry):
                    self?.uploadImage(entryId: foodEntry.id, image: image)
                case .failure(let error):
                    self?.delegate?.addEntryDidFailed(error: error)
                }
            })
        }
    }
    
    // This function upload the selected image to server
    func uploadImage(entryId: String, image: Data) {
        let request = UploadImageRequest(image: image, foodEntryId: entryId)
        self.foodEntryCoreManager.uplaodImage(request: request) { [weak self] _ in
            self?.delegate?.addEntryDidSucceeded()
        }
    }
    
    
    // MARK: - Helper methods for UI
    // Convert UIImage to data
    func getImageData(from image: UIImage) -> Data? {
        guard let data = image.jpegData(compressionQuality: 0.7) else {
            return nil
        }
        
        return data
    }
    
    func getScreenTitle() -> String {
        switch(screenMode) {
        case .add:
            return String.localizedString(with: "add_entry_food_title")
        case .edit:
            return String.localizedString(with: "edit_entry_food_title")
            
        }
    }
    
    func shouldEnableAddDateButton() -> Bool {
        return screenMode == .add
        
    }
 
}
