//
//  ProfileBarButtonItemViewModel.swift
//  linkedIn Replica
//
//  Created by Ahmed Mohiy on 17/01/2023.
//

import Foundation

class ProfileBarButtonItemViewModel {
    
    let imageUrl: String
    
    init(imageUrl: String) {
        self.imageUrl = imageUrl
    }
    
    func getImageData(completion: @escaping (Data?)->()) {
        guard let imageUrl  = URL(string: imageUrl) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: imageUrl)) { data, _, _ in
            if let data {
                completion(data)
                return
            }
            
            completion(nil)
        }.resume()
    }
    
}
