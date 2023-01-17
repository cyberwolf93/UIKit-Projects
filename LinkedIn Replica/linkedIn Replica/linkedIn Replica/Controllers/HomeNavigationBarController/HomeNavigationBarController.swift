//
//  HomeSearchBarController.swift
//  linkedIn Replica
//
//  Created by Ahmed Mohiy on 17/01/2023.
//

import UIKit

protocol HomeNavigationBarControllerDelegate: NSObjectProtocol {
    func searchDidBeginEditing()
    func searchDidEndEditing()
}

class CustomUINavigationBarDelegate:NSObject,  UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

class HomeNavigationBarController: NSObject {
    
    // MARK: Views declaration
    let navigationBar: UINavigationBar
    let navigationItem: UINavigationItem
    var searchBar: UISearchBar?
    
    // MARK: Variables
    weak var delegate: HomeNavigationBarControllerDelegate?
    
    
    init(navigationBar: UINavigationBar, navigationItem: UINavigationItem) {
        self.navigationBar = navigationBar
        self.navigationItem = navigationItem
        super.init()
        initUI()
        createProfileBarButtonItem()
        createSearchBarController()
        createChatBarButtonItem()
    }
    
    func initUI(){
        navigationBar.backgroundColor = UIColor.appSecondaryBackground
        navigationBar.barTintColor = UIColor.appSecondaryBackground
        navigationBar.isTranslucent = false
        navigationBar.barStyle = .default
        navigationBar.delegate = CustomUINavigationBarDelegate()
        
    }
    
    // create the left bar button item which contains user profile image
    func createProfileBarButtonItem(){
        let size = CGSize(width: navigationBar.frame.height  * 0.8,
                          height: navigationBar.frame.height  * 0.8)
        let profileBarItem = ProfileBarButtonItem(size: size)
        let profileBarItemViewModel = ProfileBarButtonItemViewModel(imageUrl: "https://cdn-icons-png.flaticon.com/512/3135/3135715.png")
        profileBarItem.viewModel = profileBarItemViewModel
        self.navigationItem.setLeftBarButton(profileBarItem, animated: false)
    }
    
    // Create searchbar controller
    func createSearchBarController() {
        self.searchBar = UISearchBar()
        self.searchBar?.searchTextField.attributedPlaceholder = NSAttributedString(string: "home_navigation_bar_search".localizedString(),
                                                                                   attributes: [NSAttributedString.Key.foregroundColor:UIColor.secondaryLabel])
        self.navigationItem.titleView = searchBar
        searchBar?.delegate = self
    }
    
    func createChatBarButtonItem(){
        let chatBarItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.bubble.fill"),
                                          style: .plain,
                                          target: self,
                                          action: nil)
        chatBarItem.tintColor = UIColor.appUnselectedIcon
        navigationItem.setRightBarButton(chatBarItem, animated: false)
    }
    
    
}


//MARK: UISearchBarDelegate
extension HomeNavigationBarController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar?.resignFirstResponder()
        self.delegate?.searchDidBeginEditing()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.delegate?.searchDidEndEditing()
    }
}
