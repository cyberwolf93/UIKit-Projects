//
//  UIViewControllerExtension.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 23/10/2022.
//

import UIKit

extension UIViewController {
    enum ViewControllerId: String {
        case signinViewControllerID = "Signin_viewController_ID"
        case homeTabBarControllerID = "home_tab_bar_controller_ID"
        case AddEntryViewControllerID = "add_entry_viewController_ID"
        case ReportViewControllerID = "Report_viewController_ID"
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default) { _ in
            alert.dismiss(animated: true)
            self.updateStatusBarAppearance()
        }
        
        alert.addAction(alertAction)
        self.present(alert, animated: true)
    }
    
    func updateStatusBarAppearance() {
        self.setNeedsStatusBarAppearanceUpdate()
    }
}
