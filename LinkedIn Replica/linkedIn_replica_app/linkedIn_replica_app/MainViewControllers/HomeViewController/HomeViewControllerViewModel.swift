//
//  HomeViewControllerViewModel.swift
//  linkedIn Replica
//
//  Created by Ahmed Mohiy on 06/02/2023.
//

import Foundation
import linkedin_models

protocol HomeViewControllerViewModelDelegate: NSObjectProtocol {
    func feedDidUpdate()
}

class HomeViewControllerViewModel: NSObject {
    
    var postFeed: [Post] = []
    var cellsViewModels:[IndexPath: HomeFeedCellViewModel] = [:]
    weak var delegate:HomeViewControllerViewModelDelegate?
    
    func requestFeed() {
        //TODO: Request from client api modul
        postFeed.append(createDummyData())
        postFeed.append(createDummyData())
        postFeed.append(createDummyData())
        
        for (index, post) in postFeed.enumerated() {
            let viewModel = HomeFeedCellViewModel(postData: post)
            cellsViewModels[IndexPath(row: index, section: 0)] = viewModel
        }
        
        self.delegate?.feedDidUpdate()
    }
    
    private func createDummyData() -> Post {
        
        let person = PersonIdentity(id: "1",
                                    name: "Ahmed",
                                    profileImageUrl: "profile_1",
                                    coverImageUrl: "",
                                    jobTitle: "iOS engineer",
                                    currentCompany: nil,
                                    about: "")
        
        return PersonPost(title: "",
                   iconUrl: "",
                   description: "We compiled 5 tips to help you browse the internet more safely using Chrome. These tips — especially when used alongside Chrome’s built in security features such as Google Password Manager — can help you browse safely across your devices. → http://goo.gle/3WUGkxP",
                   date: Date.getDateFrom(date: "03/02/2022"),
                   type: .image,
                   numberOfLikes: 10,
                   numberOfCeleberations: 0,
                   numberOfLove: 12,
                   numberOfSupport: 5,
                   numberOfLaugh: 0,
                   numberOfInsightful: 0,
                   numberOfCurious: 0,
                   numberOfComments: 0,
                   numberOfShares: 10,
                   person: person,
                   imageName: "google_image")
    }
}
