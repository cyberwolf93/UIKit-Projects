//
//  MyNetworkViewControllerViewModel.swift
//  linkedIn_replica_app
//
//  Created by Ahmed Mohiy on 12/02/2023.
//

import Foundation
import linkedin_models

protocol MyNetworkViewControllerViewModelDelegate: NSObjectProtocol {
    func collectionDataDidLoad()
}


class MyNetworkViewControllerViewModel {
    
    let SECTION_INDUSTRY_LEADERS_SAME_COUNTRY = "SECTION_INDUSTRY_LEADERS_SAME_COUNTRY"
    let SECTION_PEOPLE_YOU_MAY_KNOW_FROM_UNIVERSITY = "SECTION_PEOPLE_YOU_MAY_KNOW_FROM_UNIVERSITY"
    let SECTION_SOFTWARE_ENGINEER_YOU_MAY_KNOW = "SOFTWARE_ENGINEER_YOU_MAY_KNOW"
    let SECTION_MORE_SUGGESTIONS = "SECTION_MORE_SUGGESTIONS"
    
    var collectionViewData:[String:CellDataType] = [:]
    var sections: [String] = []
    weak var delegate:MyNetworkViewControllerViewModelDelegate?
    
    init() {
        sections = [SECTION_INDUSTRY_LEADERS_SAME_COUNTRY,
                    SECTION_PEOPLE_YOU_MAY_KNOW_FROM_UNIVERSITY,
                    SECTION_SOFTWARE_ENGINEER_YOU_MAY_KNOW,
                    SECTION_MORE_SUGGESTIONS]
    }
    
    func loadContent() {
        let person = PersonIdentity(id: "1",
                                    name: "Ahmed Mohiy",
                                    profileImageUrl: "profile_1",
                                    coverImageUrl: "",
                                    jobTitle: "iOS engineer",
                                    currentCompany: nil,
                                    about: "")
        
        var personsArray = [person, person, person, person]
        var celldataTypeObject = CellDataType(persons: personsArray, step: 4)
        collectionViewData[SECTION_INDUSTRY_LEADERS_SAME_COUNTRY] = celldataTypeObject
        celldataTypeObject = CellDataType(persons: personsArray, step: 4)
        collectionViewData[SECTION_PEOPLE_YOU_MAY_KNOW_FROM_UNIVERSITY] = celldataTypeObject
        celldataTypeObject = CellDataType(persons: personsArray, step: 4)
        collectionViewData[SECTION_SOFTWARE_ENGINEER_YOU_MAY_KNOW] = celldataTypeObject
        personsArray = [person, person, person, person]
        celldataTypeObject = CellDataType(persons: personsArray, step: 4)
        collectionViewData[SECTION_MORE_SUGGESTIONS] = celldataTypeObject
        
        self.delegate?.collectionDataDidLoad()
    }
    
    func getSectionTitle(section: Int) -> String {
        let sectionId = sections[section]
        switch(sectionId) {
        case SECTION_INDUSTRY_LEADERS_SAME_COUNTRY:
            return "mynetwork_screen_section_industry_leaders_same_country".localizedString()
        case SECTION_PEOPLE_YOU_MAY_KNOW_FROM_UNIVERSITY:
            return "mynetwork_screen_section_people_you_may_know_from_university".localizedString()
        case SECTION_SOFTWARE_ENGINEER_YOU_MAY_KNOW:
            return "mynetwork_screen_section_software_engineer_you_may_know".localizedString()
        case SECTION_MORE_SUGGESTIONS:
            return "mynetwork_screen_section_more_suggestions".localizedString()
        default:
            return ""
        }
        
    }
    
    func numberOfItemsIn(section: Int) -> Int {
        let sectionId = sections[section]
        guard let cellData = collectionViewData[sectionId] else {return 0}
        return cellData.numberOfItems()
    }
    
    func getCellContentFor(section: Int, row: Int) -> [PersonIdentity] {
        let sectionId = sections[section]
        guard var cellData = collectionViewData[sectionId] else {return []}
        defer {
            collectionViewData[sectionId] = cellData
        }
        return cellData.next(index: row)
    }
    
}

//MARK:
extension MyNetworkViewControllerViewModel {
    struct CellDataType {
        let persons: [PersonIdentity]
        let step: Int
        
        func next(index: Int) -> [PersonIdentity] {
            let startIndex = index * step
            guard startIndex < persons.count else {return []}
            
            let count = min(startIndex+step, persons.count)
            
            var array = [PersonIdentity]()
            for i in startIndex ..< count {
                array.append(persons[i])
            }
            
            return array
        }
        
        func numberOfItems() -> Int {
            guard persons.count > 0 else {return 0}
            if persons.count % step == 0 {
                return persons.count / step
            }
            
            return (persons.count / step) + 1
        }
    }
}
