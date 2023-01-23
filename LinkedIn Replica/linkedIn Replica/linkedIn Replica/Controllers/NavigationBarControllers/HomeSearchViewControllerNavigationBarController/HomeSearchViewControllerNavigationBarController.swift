//
//  HomeSearchViewControllerNavigationBarController.swift
//  linkedIn Replica
//
//  Created by Ahmed Mohiy on 17/01/2023.
//

import UIKit

protocol HomeSearchViewControllerNavigationBarControllerDelegate: NSObjectProtocol {
    func backButtonClicked()
}

class HomeSearchViewControllerNavigationBarController: NSObject {
    
    // MARK: Views declaration
    let navigationBar: UINavigationBar
    let navigationItem: UINavigationItem
    var searchBar: UISearchBar?
    
    
    // MARK: Variables
    weak var delegate: HomeSearchViewControllerNavigationBarControllerDelegate?
    
    init(navigationBar: UINavigationBar, navigationItem: UINavigationItem) {
        self.navigationBar = navigationBar
        self.navigationItem = navigationItem
        super.init()
        initUI()
        createBackButtonUI()
        createSearchBarController()
    }
    
    func initUI(){
        navigationBar.backgroundColor = UIColor.appSecondaryBackground
        navigationBar.barTintColor = UIColor.appSecondaryBackground
        navigationBar.isTranslucent = false
        navigationBar.barStyle = .default
    }
    
    func createBackButtonUI() {
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"),
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(backArroClicked))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.appUnselectedIcon
    }
    
    // Create searchbar controller
    func createSearchBarController() {
        self.searchBar = UISearchBar()
        self.searchBar?.searchTextField.attributedPlaceholder = NSAttributedString(string: "home_navigation_bar_search".localizedString(),
                                                                                   attributes: [NSAttributedString.Key.foregroundColor:UIColor.secondaryLabel])
        self.navigationItem.titleView = searchBar
//        searchBar?.delegate = self
    }
    
    //MARK: Actions
    @objc
    func backArroClicked() {
        self.delegate?.backButtonClicked()
    }
    
}
