//
//  BaseNavigationBarController.swift
//  linkedIn_replica_app
//
//  Created by Ahmed Mohiy on 15/02/2023.
//

import UIKit

class BaseNavigationBarController: NSObject {
    // MARK: Views declaration
    let navigationBar: UINavigationBar
    let navigationItem: UINavigationItem
    
    init(navigationBar: UINavigationBar, navigationItem: UINavigationItem) {
        self.navigationBar = navigationBar
        self.navigationItem = navigationItem
        super.init()
        initUI()
        
    }
    
    func initUI(){
        navigationBar.backgroundColor = UIColor.appSecondaryBackground
        navigationBar.barTintColor = UIColor.appSecondaryBackground
        navigationBar.isTranslucent = false
        navigationBar.barStyle = .default
        navigationBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        navigationBar.layer.shadowRadius = 1
        navigationBar.layer.shadowColor = UIColor.appUnselectedIcon.cgColor
        navigationBar.layer.shadowOpacity = 1
    }
}
