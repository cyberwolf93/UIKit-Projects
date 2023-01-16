//
//  UploadImageRequest.swift
//  NetworkCore
//
//  Created by Ahmed Mohiy on 22/10/2022.
//

import Foundation

public class UploadImageRequest: BaseNetworkRequest {

    
    //MARK:- Variabels
    let image: Data
    let foodEntryId: String
    var api: String
    
    public init(image: Data, foodEntryId: String) {
        self.image = image
        self.foodEntryId = foodEntryId
        self.api = "/upload/\(foodEntryId)"
    }
    
    // MARK:- Implementation methods
    public func build(baseUrl: String, authToken: String) -> URLRequest? {
        var urlComponnets = URLComponents(string: baseUrl + self.api)
        
        guard let url = urlComponnets?.url else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HttpMethods.post.rawValue
        // add header to the request
        let boundary = getBoundary()
        urlRequest.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        guard let jsonData = self.buildRequestBody(boundary: boundary) else {
            return nil
        }
        
        urlRequest.httpBody = jsonData
        
        return urlRequest
    }
    
    // Helper methods
    private func getBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    private func buildRequestBody(boundary: String) -> Data? {
        let lineBreak = "\r\n"
        var data = Data()
        data.append(contentsOf: "--\(boundary + lineBreak)".utf8)
        data.append(contentsOf: "Content-Disposition: form-data; name=\"image\"; filename=\"food.jpg\"\(lineBreak)".utf8)
        data.append(contentsOf: "Content-Type: image/jpeg \(lineBreak + lineBreak)".utf8)
        data.append(contentsOf: self.image)
        data.append(contentsOf: lineBreak.utf8)
        data.append(contentsOf: "--\(boundary)--\(lineBreak)".utf8)
        
        return data
    }
}
