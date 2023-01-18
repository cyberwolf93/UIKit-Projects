//
//  MainAppContainerViewController.swift
//  linkedIn Replica
//
//  Created by Ahmed Mohiy on 18/01/2023.
//

import UIKit

class MainAppContainerViewController: UIViewController {
    
    var sideMenuViewController: SideMenuViewController?
    var maintTabBarViewController: MainTabBarViewController?
    var messagesViewController: MessagesViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createsSideMenuViewController()
        createMaintTabBarViewController()
        createMessagesViewController()
    }
    
    // MARK: View Controller creation
    func createsSideMenuViewController() {
        
    }
    
    func createMaintTabBarViewController() {
        
    }
    
    func createMessagesViewController() {
        
    }
}
