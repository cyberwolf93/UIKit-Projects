//
//  MessageViewControllerViewModel.swift
//  linkedIn_replica_app
//
//  Created by Ahmed Mohiy on 13/02/2023.
//

import Foundation
import linkedin_models

protocol MessageViewControllerViewModelDelegate: NSObjectProtocol{
    func messageDidLoad()
}

class MessageViewControllerViewModel {
    
    var messages = [MessageEntity]()
    weak var delegate:MessageViewControllerViewModelDelegate?
    
    func loadMessages() {
        let person = PersonIdentity(id: "1",
                                     name: "Ahmed Mohiy",
                                     profileImageUrl: "profile_1",
                                     coverImageUrl: "",
                                     jobTitle: "iOS engineer",
                                     currentCompany: nil,
                                     about: "")
        let message1 = MessageEntity(message: ["ahsdga ahshasj hsahjdhjgas hsghjsadg"], person: person, date: Date.getDateFrom(date: "22/10/2022"))
        let message2 = MessageEntity(message: ["ahsdga ahshasj hsahjdhjgas hsghjsadg"], person: person, date: Date.getDateFrom(date: "22/10/2021"))
        let message3 = MessageEntity(message: ["ahsdga ahshasj ashdhgjsa sahdjhshjgasd hdshgjsahgjsda jhdgjhsahgjsdahjg hjdhgjjhgsashjdga hgjsdjghsdajhg hsahjdhjgas hsghjsadg"], person: person, date: Date.getDateFrom(date: "22/01/2023"))
        let message4 = MessageEntity(message: ["ahsdga ahshasj hsahjdhjgas hsghjsadg"], person: person, date: Date.getDateFrom(date: "10/02/2023"))
        let message5 = MessageEntity(message: ["ahsdga ahshasj hsahjdhjgas hsghjsadg"], person: person, date: Date(timeIntervalSinceNow: -1000))
        
        
        
        messages = [message1,message2,message3,message4,message5]
        self.delegate?.messageDidLoad()
    }
}
