//
//  NotificationsViewController.swift
//  linkedIn Replica
//
//  Created by Ahmed Mohiy on 17/01/2023.
//

import UIKit

class NotificationsViewController: UIViewController {
    
    //MARK: Views
    var homeNavigationBarController: HomeNavigationBarController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
    }
    
    func initNavigationBar() {
        if let navigationBar = self.navigationController?.navigationBar {
            homeNavigationBarController = HomeNavigationBarController(navigationBar: navigationBar,
                                                                      navigationItem: navigationItem)
            homeNavigationBarController?.delegate = self
        }
    }
}

//MARK: HomeNavigationBarControllerDelegate
extension NotificationsViewController: HomeNavigationBarControllerDelegate {
    func searchDidBeginEditing() {
        self.navigateToSearchSuggestionViewController()
    }
    
    func searchDidEndEditing() {
        
    }
}

//MARK: Navigation handler
extension NotificationsViewController {
    func navigateToSearchSuggestionViewController() {
        guard let viewControlelr = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: HomeSearchViewController.storyboardId) as? HomeSearchViewController else {
            return
        }
        self.navigationController?.pushViewController(viewControlelr, animated: false)
    }
}
