//
//  MessageNavigationBarController.swift
//  linkedIn_replica_app
//
//  Created by Ahmed Mohiy on 15/02/2023.
//

import UIKit

class MessageNavigationBarController: BaseNavigationBarController {
    // MARK: Views declaration
    var searchBar: UISearchBar?
    
    override init(navigationBar: UINavigationBar, navigationItem: UINavigationItem) {
        super.init(navigationBar: navigationBar, navigationItem: navigationItem)
        
        createSearchBarController()
        createBackButton()
        createRightButtons()
        
    }
    
    override func initUI() {
        super.initUI()
        navigationBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        navigationBar.layer.shadowRadius = 0.2
        navigationBar.layer.shadowOpacity = 0.4
        navigationBar.layer.masksToBounds = false
    }
    
    //MARK: - Creat ui
    func createSearchBarController() {
        self.searchBar = UISearchBar()
        self.searchBar?.searchTextField.attributedPlaceholder = NSAttributedString(string: "home_navigation_bar_search_messages".localizedString(),
                                                                                   attributes: [NSAttributedString.Key.foregroundColor:UIColor.secondaryLabel])
        searchBar?.frame = self.navigationItem.titleView?.frame ?? .zero
        
        let buttonFilter = UIButton()
        buttonFilter.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        buttonFilter.tintColor = .appSelectedIcon
        buttonFilter.translatesAutoresizingMaskIntoConstraints = false
        searchBar?.searchTextField.addSubview(buttonFilter)
        NSLayoutConstraint.activate([
            buttonFilter.topAnchor.constraint(equalTo: searchBar!.searchTextField.topAnchor),
            buttonFilter.rightAnchor.constraint(equalTo: searchBar!.searchTextField.rightAnchor, constant: -5),
            buttonFilter.bottomAnchor.constraint(equalTo: searchBar!.searchTextField.bottomAnchor),
        ])
        
        self.navigationItem.titleView = searchBar
//        searchBar?.delegate = self
    }
    
    func createBackButton() {
        navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem()
        backButton.image = UIImage(systemName: "arrow.left")
        backButton.tintColor = .appSelectedIcon
        navigationItem.leftBarButtonItem = backButton
    }
    
    func createRightButtons() {
        let moreButton = UIBarButtonItem()
        moreButton.image = UIImage(systemName: "ellipsis")
        moreButton.tintColor = .appSelectedIcon
        
        let newMessageButton = UIBarButtonItem()
        newMessageButton.image = UIImage(systemName: "square.and.pencil")
        newMessageButton.tintColor = .appSelectedIcon
        newMessageButton.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        
        navigationItem.rightBarButtonItems = [newMessageButton, moreButton]
    }
    
}
