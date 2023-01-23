//
//  MainAppContainerViewController.swift
//  linkedIn Replica
//
//  Created by Ahmed Mohiy on 18/01/2023.
//

import UIKit

class MainAppContainerViewController: UIViewController, DescendantforContainerTransitionController {
    
    
    
    //MARK: Views
    var sideMenuViewController: SideMenuViewController?
    var mainTabBarViewController: MainTabBarViewController?
    var messagesViewController: MessagesViewController?
    var selectedViewController: UIViewController?
    
    //MARK: Variables
    var mainContainerTransitionController: MainContainerTransitionController? = MainContainerTransitionController()
    
    // MARK: Viewcontroller lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        createsSideMenuViewController()
        createMaintTabBarViewController()
        createMessagesViewController()
        createMainContainerTransitionController()
        addChildrenViewToParent()
        addObservers()
        selectedViewController = mainTabBarViewController
    }
    
    deinit {
        if let transitionController = mainContainerTransitionController {
            NotificationCenter.default.removeObserver(transitionController)
        }
        
    }
    
    //MARK: Helper Methods
    func addObservers() {
        if let transitionController = mainContainerTransitionController {
            NotificationCenter.default.addObserver(transitionController,
                                                   selector: #selector(transitionController.handleProfileBarButtonClicked),
                                                   name: Notification.Name.profileBarButtonClicked,
                                                   object: nil)
            
            NotificationCenter.default.addObserver(transitionController,
                                                   selector: #selector(transitionController.handleMessageBarButtonClicked),
                                                   name: Notification.Name.messageBarButtonClicked,
                                                   object: nil)
        }
        
    }
    
    func addChildrenViewToParent() {
        // Sidemenu view
        view.addSubview(sideMenuViewController!.view)
        sideMenuViewController?.didMove(toParent: self)
        
        // MainTabBar view
        view.addSubview(mainTabBarViewController!.view)
        mainTabBarViewController?.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainTabBarViewController!.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainTabBarViewController!.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            mainTabBarViewController!.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            mainTabBarViewController!.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        mainTabBarViewController?.didMove(toParent: self)
        
        //Messaged view
        view.addSubview(messagesViewController!.view)
        messagesViewController?.didMove(toParent: self)
    }
    
    // MARK: - View Controller creation
    func createsSideMenuViewController() {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: SideMenuViewController.storyboardId) as? SideMenuViewController else {
            print("Faield to create sideMenuViewController")
            return
        }
        sideMenuViewController = viewController
        sideMenuViewController?.mainContainerTransitionController = mainContainerTransitionController
        sideMenuViewController?.view.frame = CGRect(x: -(self.view.frame.width*0.8), y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
    }
    
    func createMaintTabBarViewController() {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: MainTabBarViewController.storyboardId) as? MainTabBarViewController else {
            print("Faield to create MainTabBarViewController")
            return
        }
        mainTabBarViewController = viewController
        mainTabBarViewController?.mainContainerTransitionController = mainContainerTransitionController
        view.addSubview(createNavigationBarExtension(for: view))
    }
    
    func createMessagesViewController() {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: MessagesViewController.storyboardId) as? MessagesViewController else {
            print("Faield to create MessagesViewController")
            return
        }
        messagesViewController = viewController
        messagesViewController?.mainContainerTransitionController = mainContainerTransitionController
        messagesViewController?.view.frame = CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height)
    }
    
    func createMainContainerTransitionController() {
        guard let sidemenuView = sideMenuViewController?.view,
              let mainTabBarView = mainTabBarViewController?.view,
              let messagesView = messagesViewController?.view else {
            return
        }
        mainContainerTransitionController?.initializeViews(sideMenuView: sidemenuView,
                                                          mainTabBarView: mainTabBarView,
                                                          messagesView: messagesView)
    }
    
    // This view to be behind status bar with the same color as navigation bar
    func createNavigationBarExtension(for paretnView: UIView) -> UIView {
        let view = UIView()
        paretnView.addSubview(view)
        view.backgroundColor = UIColor.appSecondaryBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: paretnView.topAnchor),
            view.leftAnchor.constraint(equalTo: paretnView.leftAnchor),
            view.rightAnchor.constraint(equalTo: paretnView.rightAnchor),
            view.bottomAnchor.constraint(equalTo: paretnView.safeAreaLayoutGuide.topAnchor)
        ])
        return view
    }
    
    
}
