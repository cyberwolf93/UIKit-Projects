//
//  ProfileData.swift
//  Data_Mocks
//
//  Created by Ahmed Mohiy on 26/01/2023.
//

import Foundation

internal class ProfileData {
    
    var data: [String: Any] = [:]
    
    init() {
        createData()
    }
    
    private func createData() {
        data = [
            id: UUID().uuidString,
            name: "Ahmed Mohiy",
            profile_image_url: "",
            cover_image_url: "",
            job_title: "Software Engineer - iOS Developer"
            current_company: currentCompany(), //TODO:
            about: "I am a passionate software eingineer. I have been working as an iOS developer of over 4 years now. I worked with complex applications with thousands of subscribed users.\nI am driven by learning about new technologies regularly. Trying to keep up with new innovation technologies. Writing reusable, scalable and maintainable software is the main goal here.",
            experience: getExperiences(),
            education: [
                school_name: "Cairo University",
                degree: "Bachelor's degree",
                field_of_study: "Computer Science",
                start_date: Date.getDateFrom(date: "02/06/2013"),
                end_date: Date.getDateFrom(date: "02/09/2017"),
                country: "Egypt"
            ],
            licensesAndCerts: getLicenseOrCertificate(),
            skills: ["CocoaPods", "Cocoa Touch", "iOS", "Swift", "tvOS", "javascript"]
        ]
    }
    
    private func currentCompany() -> [String:Any] {
        return [
            id: UUID().uuidString,
            name: "Inmobly",
            profile_image_url: "",
            cover_image_url: "",
            industry: DataEnumsRefrence.industry_it_services_and_it_consulting,
            number_of_followers: 2000,
            overView: "inmobly tackles the challenge of the ever growing demand for mobile data traffic by using sophisticated prediction and scheduling algorithms to shift network usage. inmobly's innovative solutions help MNO/MVNO’s optimize their data traffic, content providers deliver their content efficiently, and allow end-users to enjoy a unique user experience of personalized, multimedia-rich content that meets their interests without breaking their budgets with data charges.",
            website: "http://www.inmobly.com",
            company_size: 25,
            headquarters: "1275 Kinnear Road, Columbus, Ohio 43212, US",
            type: DataEnumsRefrence.company_type_private,
            specialities:"Mobile technology, Saas, Prediction, Scheduling, Machine Learning, Video, Multimedia, Content Management, Caching, OTT Solutions, Application Development, Customization, and Digital Adverstising",
            funding: [getCurrentCompanyFunding()],
            locations: [[address:"1275 Kinnear Road, Columbus, Ohio 43212, US",
                     is_primary: true,
                       latitude: "39.997307",
                      longitude: "-83.04244",
                        country: "USA"]]
        ]
        
    }
    
    private func getCurrentCompanyFunding() -> [String:Any] {
        return [
            currency: "US",
            number_of_round: 1,
            last_round_date: Date(timeIntervalSinceNow: -123131222),
            number_of_investors: 1,
            amount: 500000,
            type: DataEnumsRefrence.funding_type_raised
        ]
    }
    
    private func getExperiences() -> [[String:Any]] {
        var experience_1 = [
            title: "Frontend web developer",
            headline: "Frontend web developer",
            position_type: DataEnumsRefrence.job_position_type_full_time,
            location: "Cairo, Egypt",
            is_currenty_active: false,
            start_date: Date.getDateFrom(date: "02/06/2017"),
            end_date: Date.getDateFrom(date: "29/11/2018"),
            description: "- Published multiple OTT services apps to web and cross-platforms./n- Worked with technologies like: JavaScript ECMAScript 5.1 , HTML5 ,CSS3, SASS, Gulp.js, Angularjs, Apache cordova/n- Delivered apps on smartvs like (Samsung, LG and android TV)",
            company: currentCompany(),
            skills: []
        ]
        
        var experience_2 = [
            title: "iOS developer",
            headline: "iOS developer",
            position_type: DataEnumsRefrence.job_position_type_full_time,
            location: "Cairo, Egypt",
            is_currenty_active: true,
            start_date: Date.getDateFrom(date: "02/12/2018"),
            description: "- Delivering multiple OTT services iOS and tvOS apps/n- Writing, maintaining and enhancing modules./n- Major refactoring in important features like (analytics, downloads, etc.)- Delivering multiple OTT services iOS and tvOS apps - Writing, maintaining and enhancing modules. - Major refactoring in important features like (analytics, downloads, etc.)",
            company: currentCompany(),
            skills: ["CocoaPods", "Cocoa Touch", "iOS", "Swift 4"]
        ]
        
        return [experience_1, experience_2]
    }
    
    private getLicenseOrCertificate() -> [[String:Any]] {
        let cert_1 = [
            name: "Software Architecture: From Developer to Architect",
            organization_name: "LinkedIn",
            issue_date: Date.getDateFrom(date: "02/01/2023"),
            certificate_url: "https://www.linkedin.com/learning/certificates/5005904da02fc783df2f3909e3570479609beb58182e7a87f6aafafa11549366"
        ]
        
        let cert_2 = [
            name: "Git Essential Training: The Basics",
            organization_name: "LinkedIn",
            issue_date: Date.getDateFrom(date: "02/09/2022"),
            certificate_url: "https://www.linkedin.com/learning/certificates/3dd3fbd56d8a18a49d8760fa15f720b0c00d422c5f9b9b703d5e413628061569"
        ]
        
        let cert_3 = [
            name: "iOS Core Bluetooth for Developers",
            organization_name: "LinkedIn",
            issue_date: Date.getDateFrom(date: "19/07/2022"),
            certificate_url: "https://www.linkedin.com/learning/certificates/2e6c23e9cdeb4d1d0b5c26f2ebebc27bec97c4db652407af13df8876ae9fae6c?trk=share_certificate"
        ]
        
        return [cert_1, cert_2, cert_3]
    }
    
    func getSerializedData() -> Data? {
        do {
            let serializedData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            return serializedData
        } catch {
            return nil
        }
    }
    
}
