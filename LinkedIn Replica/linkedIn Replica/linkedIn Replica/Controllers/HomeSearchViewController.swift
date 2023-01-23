//
//  HomeSearchViewController.swift
//  linkedIn Replica
//
//  Created by Ahmed Mohiy on 17/01/2023.
//

import UIKit

class HomeSearchViewController: UIViewController {
    
    var navigationBarController: HomeSearchViewControllerNavigationBarController?
    
    static var storyboardId: String {
        get {
            "HomeSearchViewControllerID"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        initNavigationBar()
    }
    
    func initNavigationBar() {
        
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBarController = HomeSearchViewControllerNavigationBarController(navigationBar: navigationBar,
                                                                      navigationItem: navigationItem)
            navigationBarController?.delegate = self
        }
    }
    
}

//MARK: HomeNavigationBarControllerDelegate
extension HomeSearchViewController: HomeSearchViewControllerNavigationBarControllerDelegate {
    func backButtonClicked() {
        self.navigationController?.popViewController(animated: false)
    }
}


