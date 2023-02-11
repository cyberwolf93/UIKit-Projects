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
    func profileBarButtonDidClick()
    func messageBarButtonDidClick()
}


// implement default values for HomeNavigationBarControllerDelegate
extension HomeNavigationBarControllerDelegate {
    func searchDidBeginEditing() {}
    func searchDidEndEditing() {}
    func profileBarButtonDidClick() {
        NotificationCenter.default.post(Notification(name: Notification.Name.profileBarButtonClicked))
    }
    func messageBarButtonDidClick() {
        NotificationCenter.default.post(Notification(name: Notification.Name.messageBarButtonClicked))
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
        navigationBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        navigationBar.layer.shadowRadius = 1
        navigationBar.layer.shadowColor = UIColor.appUnselectedIcon.cgColor
        navigationBar.layer.shadowOpacity = 1
        
    }
    
    // create the left bar button item which contains user profile image
    func createProfileBarButtonItem(){
        let size = CGSize(width: navigationBar.frame.height  * 0.8,
                          height: navigationBar.frame.height  * 0.8)
        
        let profileBarItem = ProfileBarButtonItem(size: size, target: self, action: #selector(profileBarButtonDidClick))
        let profileBarItemViewModel = ProfileBarButtonItemViewModel(imageUrl: "https://cdn-icons-png.flaticon.com/512/3135/3135715.png")
        profileBarItem.viewModel = profileBarItemViewModel
        self.navigationItem.setLeftBarButtonItems([UIBarButtonItem(), UIBarButtonItem(), UIBarButtonItem(),UIBarButtonItem(),profileBarItem], animated: false)
    }
    
    // Create searchbar controller
    func createSearchBarController() {
        self.searchBar = UISearchBar()
        self.searchBar?.searchTextField.attributedPlaceholder = NSAttributedString(string: "home_navigation_bar_search".localizedString(),
                                                                                   attributes: [NSAttributedString.Key.foregroundColor:UIColor.secondaryLabel])
        searchBar?.frame = self.navigationItem.titleView?.frame ?? .zero
        self.navigationItem.titleView = searchBar
        searchBar?.delegate = self
    }
    
    func createChatBarButtonItem(){
        let chatBarItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.bubble.fill"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(messageBarButtonDidClick))
        chatBarItem.tintColor = UIColor.appUnselectedIcon
        chatBarItem.imageInsets = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0)
        navigationItem.rightBarButtonItems = [UIBarButtonItem(), chatBarItem]
    }
    
    //MARK: Actions
    @objc
    func profileBarButtonDidClick() {
        self.delegate?.profileBarButtonDidClick()
    }
    
    @objc
    func messageBarButtonDidClick() {
        self.delegate?.messageBarButtonDidClick()
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
