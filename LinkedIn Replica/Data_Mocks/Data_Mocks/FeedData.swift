//
//  FeedData.swift
//  Data_Mocks
//
//  Created by Ahmed Mohiy on 01/02/2023.
//

import Foundation

class FeedData {
    var data: [[String: Any]] = []
    
    init() {
        createData()
    }
    
    //MARK: - Data creation
    private func createData() {
        createFeed1()
        createFeed2()
    }
    
    private func createFeed1() {
        data.append([
            "id": "2dbb8d49-02b5-4298-bf27-3ad2f73c3115",
            "description": "We compiled 5 tips to help you browse the internet more safely using Chrome. These tips — especially when used alongside Chrome’s built in security features such as Google Password Manager — can help you browse safely across your devices. → http://goo.gle/3WUGkxP",
            "date": Date.getDateFrom(date: "03/02/2022"),
            "type": DataEnumsRefrence.post_type_video,
            "number_of_likes": 10,
            "number_of_celeberations": 2,
            "number_of_love": 1,
            "video_url": "https://www.youtube.com/watch?v=D-O5gldkDIs",
            "company": ["id": "69f43a74-bf6a-4896-9cc5-2e9ef8811712",
                        "name": "Google",
                        "profile_image_url": "",
                        "cover_image_url": "",
                        "number_of_followers": 27_671_016,
                        "funding": [],
                        "locations": []
                       ]
        ])
    }
    
    private func createFeed2() {
        data.append([
            "id": "00d5cf0e-53a8-41f4-a28c-73912d4fe2f9",
            "description": "At CES 2023 earlier this month, we showcased the latest on Android’s multi-device experiences. We’ve been working with our partners to connect all of our Android devices — phones, TVs, cars, and more — so people can get things done more seamlessly across devices. Learn more about the progress we showcased at CES → https://goo.gle/3R5Ht4C",
            "date": Date.getDateFrom(date: "03/04/2020"),
            "type": DataEnumsRefrence.post_type_article,
            "number_of_likes": 100,
            "number_of_celeberations": 3,
            "number_of_love": 10,
            "article_url": "https://goo.gle/3R5Ht4C",
            "article_title": "",
            "company": ["id": "ECA2A243-754A-426C-BE8F-F847C1FB25E3",
                        "name": "Amazon",
                        "profile_image_url": "",
                        "cover_image_url": "",
                        "number_of_followers": 29_263_159,
                        "funding": [],
                        "locations": []
                       ]
        ])
    }
    
    private func createFeed3() {
        data.append([
            "id": "00d5cf0e-53a8-41f4-a28c-73912d4fe2f9",
            "description": "2022 was a year of meaningful climate progress. We moved closer to our carbon neutral goal with a 31% reduction in greenhouse gas emissions since 2019. Plus, we took a critical step in joining the Science Based Targets initiative on climate action.Check out the progress we’ve made: https://comca.st/3XHoFv0",
            "date": Date.getDateFrom(date: "03/12/2022"),
            "type": DataEnumsRefrence.post_type_video,
            "number_of_likes": 5,
            "number_of_celeberations": 3,
            "number_of_love": 10,
            "number_of_comments": 1,
            "company": ["id": "38879849-63ED-4627-883B-20AE2FFD0A59",
                        "name": "Comcast",
                        "profile_image_url": "",
                        "cover_image_url": "",
                        "number_of_followers": 542_617,
                        "funding": [],
                        "locations": []
                       ]
        ])
    }
    
    private func createFeed4() {
        data.append([
            "id": "5735db78-27de-4572-b923-a4b413fe8dbc",
            "description": "This just in: Amazon set a new record for most renewable energy purchased in a single year./n/nOnce operational, our 401 renewable energy projects around the world will total more than 20 GW and are expected to generate enough clean energy to power 5.3 million U.S. homes./n/nWe are making significant progress on our path to powering our operations with 100% renewable energy by 2025, five years ahead of our original 2030 target. ♻️ https://amzn.to/3JKSh6H",
            "date": Date.getDateFrom(date: "03/11/2021"),
            "type": DataEnumsRefrence.post_type_image,
            "number_of_likes": 50,
            "number_of_celeberations": 30,
            "number_of_love": 100,
            "number_of_comments": 5,
            "company": ["id": "ECA2A243-754A-426C-BE8F-F847C1FB25E3",
                        "name": "Amazon",
                        "profile_image_url": "",
                        "cover_image_url": "",
                        "number_of_followers": 29_263_159,
                        "funding": [],
                        "locations": []
                       ]
        ])
    }
}
