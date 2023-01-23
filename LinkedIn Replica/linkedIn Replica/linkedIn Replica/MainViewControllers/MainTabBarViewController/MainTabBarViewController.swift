//
//  ViewController.swift
//  linkedIn Replica
//
//  Created by Ahmed Mohiy on 16/01/2023.
//

import UIKit

class MainTabBarViewController: UITabBarController, DescendantforContainerTransitionController {
    
    //MARK: Views
    var viewTabBarSelection: UIView?
    var postViewControllerIndex = 2
    
    //MARK: Variables
    let numberOfbarItems = 5
    static let storyboardId: String = "MainTabBarViewControllerVCID"
    weak var mainContainerTransitionController: MainContainerTransitionController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        initUI()
        addViewTransitionPanGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view did appear")
    }
    
    //MARK: - Helper methods
    func addViewTransitionPanGesture(){
        if let transitionContainer = self.mainContainerTransitionController {
            let gesture = UIPanGestureRecognizer(target: transitionContainer, action: #selector(transitionContainer.handlePanGestureRecognizer(_:)))
            self.view.addGestureRecognizer(gesture)
        }
    }
    
    //MARK: - UI Customization
    func initUI() {
        initTabBarUI()
    }
    
    func initTabBarUI() {
        tabBar.isTranslucent = false
        tabBar.tintColor = UIColor.appSelectedIcon
        tabBar.barTintColor = UIColor.appSecondaryBackground
        tabBar.backgroundColor = UIColor.appSecondaryBackground
        tabBar.unselectedItemTintColor = UIColor.appUnselectedIcon
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 1
        tabBar.layer.shadowColor = UIColor.appUnselectedIcon.cgColor
        tabBar.layer.shadowOpacity = 1
        initTabBarItemUI()
        initTabBarItemSelectedView()
    }

    func initTabBarItemUI() {
        guard let items = tabBar.items, items.count == numberOfbarItems else {
            return
        }
        
        // set Home item UI
        items[0].image = UIImage(systemName: "house")
        items[0].selectedImage = UIImage(systemName: "house.fill")
        items[0].title = "tab_bar_item_home".localizedString()
        
        // set My network item UI
        items[1].image = UIImage(systemName: "person.2")
        items[1].selectedImage = UIImage(systemName: "person.2.fill")
        items[1].title = "tab_bar_item_my_network".localizedString()
        
        // set Post item UI
        items[2].image = UIImage(systemName: "plus.app.fill")
        items[2].selectedImage = UIImage(systemName: "plus.app.fill")
        items[2].title = "tab_bar_item_post".localizedString()
        
        // set Notification item UI
        items[3].image = UIImage(systemName: "bell")
        items[3].selectedImage = UIImage(systemName: "bell.fill")
        items[3].title = "tab_bar_item_notifications".localizedString()
        
        // set Notification item UI
        items[4].image = UIImage(systemName: "briefcase")
        items[4].selectedImage = UIImage(systemName: "briefcase.fill")
        items[4].title = "tab_bar_item_jobs".localizedString()
        
    }
    
    func initTabBarItemSelectedView() {
        viewTabBarSelection = UIView()
        viewTabBarSelection?.backgroundColor = UIColor.appSelectedIcon
        viewTabBarSelection?.translatesAutoresizingMaskIntoConstraints = false
        tabBar.addSubview(viewTabBarSelection!)
        
        // viewTabBarSelection constraints
        NSLayoutConstraint.activate([
            viewTabBarSelection!.topAnchor.constraint(equalTo: tabBar.topAnchor),
            viewTabBarSelection!.leftAnchor.constraint(equalTo: tabBar.leftAnchor),
            viewTabBarSelection!.widthAnchor.constraint(equalTo: tabBar.widthAnchor, multiplier: 0.2),
            viewTabBarSelection!.heightAnchor.constraint(equalToConstant: 3)
        ])
        
    }
    
    
    
    //MARK: Override parent methods
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        // change tab bar shadow color
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            tabBar.layer.shadowColor = UIColor.appUnselectedIcon.cgColor
        }
        
        
    }

}

// MARK: UITabBarDelegate
extension MainTabBarViewController {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let index = tabBar.items?.firstIndex(of: item), index != postViewControllerIndex else {
            return
        }
        let itemWidth = tabBar.frame.width * 0.2
        let newX = itemWidth * CGFloat(index) + itemWidth/2
        UIView.animate(withDuration: 0.2, delay: 0) {
            self.viewTabBarSelection?.center.x = newX
        }
    }
}

//MARK: UITabBarControllerDelegate
extension MainTabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController == tabBarController.children[postViewControllerIndex] {
            // TODO: Add post viewController
            return false
        }
        
        return true
    }
}
