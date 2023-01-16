//
//  HomeTabBarController.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 23/10/2022.
//

import UIKit

class HomeTabBarController: UITabBarController {
    
    @IBInspectable var initialIndex: Int = 0
    
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedIndex = initialIndex
        tabBarUI()
        tabBarItemUI()
    }
   
   
    
    //MARK: - tab bar ui
    func tabBarUI() {
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .yellow2
    }
    
    // MARK: - Tab bar item UI
    func tabBarItemUI() {
        if let items = self.tabBar.items {
            for item in items {
               
                switch (item.tag) {
                case itemTag.account.rawValue:
                    // Update account bar item
                    item.image = UIImage(systemName: "person.fill")//?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal)
                    item .title = String.localizedString(with: "account")
                case itemTag.dashboard.rawValue:
                    // Update dashboard bar item
                    item.image = UIImage(systemName: "house.fill")//?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal)
                    item .title = String.localizedString(with: "dashboard")
                    
                case itemTag.settings.rawValue:
                    // Update settings bar item
                    item.image = UIImage(systemName: "gearshape.fill")//?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal)
                    item .title = String.localizedString(with: "setting")
                default:
                    break
                }
                
                
                
            }
        }
    }
    
    //MARK: - Actions
    @IBAction func navBarAddButtonClicked(_ sender: Any) {
        if let VC  = self.selectedViewController as? DashboardViewController {
            // Open add entry for admin to create entry for another user
            if VC.viewModel.userIsAdmin(),  let user = VC.viewModel.getSelectedUser() {
                self.navigationController?.showAddEntryViewController(with: VC, userId: user.id)
                return
            }
            
            // Open add entry for normal to create entry
            if !VC.viewModel.userIsAdmin(), let user = AppPreferences.shared.getUser() {
                self.navigationController?.showAddEntryViewController(with: VC, userId: user.id)
                return
            }
            
            self.showErrorAlert(message: String.localizedString(with: "admin_failed_select_user"))
        }
        
    }
    
    
    
    //MARK: Tab bar items tag
    enum itemTag: Int {
        case account = 111
        case dashboard = 222
        case settings = 333
    }
}
