//
//  UIColorExtension.swift
//  linkedIn Replica
//
//  Created by Ahmed Mohiy on 16/01/2023.
//

import UIKit

extension UIColor {
    
    static var appBackground: UIColor {
        get {
            UIColor(named: "AppBackgroundColor") ?? .white
        }
    }
    
    static var appSecondaryBackground: UIColor {
        get {
            UIColor(named: "SecondaryBackgroundColor") ?? .white
        }
    }
    
    static var appSelectedIcon: UIColor {
        get {
            UIColor(named: "AppSelectedIconColor") ?? .white
        }
    }
    
    static var appUnselectedIcon: UIColor {
        get {
            UIColor(named: "AppUnselectedIconColor") ?? .white
        }
    }
}
