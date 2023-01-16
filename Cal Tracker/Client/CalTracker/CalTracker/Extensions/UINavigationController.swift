//
//  UINavigationController.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 23/10/2022.
//

import UIKit

extension UINavigationController {
    
    // Open sign in screen and reset the navigation stack
    func showSigninScreen() {
        if let signinVC = UIStoryboard(name: UIStoryboard.StoryboradName.main.rawValue,
                                       bundle: .main).instantiateViewController(withIdentifier: UIViewController.ViewControllerId.signinViewControllerID.rawValue) as? SigninViewController {
            self.setViewControllers([signinVC], animated: true)
        }
    }
    
    // Open home tab bar controller and reset the navigation stack
    func showHomeTabBarController() {
        if let homeTabBar = UIStoryboard(name: UIStoryboard.StoryboradName.main.rawValue,
                                       bundle: .main).instantiateViewController(withIdentifier: UIViewController.ViewControllerId.homeTabBarControllerID.rawValue) as? HomeTabBarController {
            self.setViewControllers([homeTabBar], animated: true)
        }
    }
    
    
    // Present Add Entry viewController
    func showAddEntryViewController(with parent: UIViewController, userId: String, screenMode: AddFoodScreenMode = .add, foodEntry: FoodEntry? = nil) {
        if let addEntryVC = UIStoryboard(name: UIStoryboard.StoryboradName.main.rawValue,
                                       bundle: .main).instantiateViewController(withIdentifier: UIViewController.ViewControllerId.AddEntryViewControllerID.rawValue) as? AddFoodEntryViewController {
            addEntryVC.modalPresentationStyle = .popover
            addEntryVC.selectedUserId = userId
            addEntryVC.screenMode = screenMode
            addEntryVC.oldFoodEntry = foodEntry
            if let parentVC = parent as? AddFoodEntryViewControllerDelegate {
                addEntryVC.parentPresenter = parentVC
            }
            
            parent.present(addEntryVC, animated: true)
        }
    }
    
    // Show report screen
    func showReportScreen() {
        if let reportViewController = UIStoryboard(name: UIStoryboard.StoryboradName.main.rawValue,
                                                   bundle: .main).instantiateViewController(withIdentifier: UIViewController.ViewControllerId.ReportViewControllerID.rawValue) as? ReportViewController {
            
            self.pushViewController(reportViewController, animated: true)
        }
    }
    
}
