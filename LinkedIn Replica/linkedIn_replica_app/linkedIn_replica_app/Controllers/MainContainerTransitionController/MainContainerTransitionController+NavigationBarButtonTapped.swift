//
//  newfile.swift
//  linkedIn Replica
//
//  Created by Ahmed Mohiy on 21/01/2023.
//

import UIKit

//MARK: - Show and hide views on tapping
extension MainContainerTransitionController {
    func showSideMenuView() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.mainTabBarView.frame.origin.x = self.mainTabBarView.frame.width  * 0.8
            self.sideMenuView.frame.origin.x = 0
        }, completion: { _ in
            self.presentedView = self.sideMenuView
        })
        
    }
    
    func hideSideMenuView() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.mainTabBarView.frame.origin.x = 0
            self.sideMenuView.frame.origin.x = -(self.mainTabBarView.frame.width  * 0.8)
        }, completion: { _ in
            self.presentedView = self.mainTabBarView
        })
    }
    
    func showMessagesView() {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.mainTabBarView.frame.origin.x = -self.mainTabBarView.frame.width
            self.messagesView.frame.origin.x = 0
        }, completion: { _ in
            self.presentedView = self.messagesView
        })
        
    }
    
    func HideMessagesView() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.mainTabBarView.frame.origin.x = 0
            self.messagesView.frame.origin.x = self.mainTabBarView.frame.width
        }, completion: { _ in
            self.presentedView = self.mainTabBarView
        })
        
    }
}
