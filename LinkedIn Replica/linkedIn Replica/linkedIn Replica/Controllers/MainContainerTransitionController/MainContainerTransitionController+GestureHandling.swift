//
//  MainContainerTransitionController+GestureHandling.swift
//  linkedIn Replica
//
//  Created by Ahmed Mohiy on 21/01/2023.
//

import UIKit

extension MainContainerTransitionController {
    
    // MARK: - Gesture state handle functions
    func shouldApplyTransition(with gesture: UIPanGestureRecognizer) -> Bool {
        switch(gesture.velocity(in: self.presentedView).x , self.presentedView) {
        // selected view: mainTabBarView and gesture direction: right
        case (_, let view ) where view == mainTabBarView :
            return true
        
        // selected view: sideMenu and gesture direction: left
        case (let x, let view ) where view == sideMenuView && x <= 0  :
            return true
            
        // selected view: sideMenu and gesture direction: right and sidemenu not fully visable
        case (let x, let view ) where view == sideMenuView && x > 0 && view.frame.origin.x < 0:
            return true
            
        // selected view: messagesView and gesture direction: right
        case (let x, let view ) where view == messagesView &&  x >= 0 :
            return true
            
        // selected view: messagesView and gesture direction: right and messagesView not fully visable
        case (let x, let view ) where view == messagesView && x < 0 && view.frame.origin.x > 0:
            return true
        default:
            return false
        }
    }
    
    // MARK: - handle gesture state changed for view
    func handleHandlePanGestureStateChanged(gesture: UIPanGestureRecognizer) {
        let newX = presentedView.frame.origin.x + gesture.translation(in: presentedView).x
        
        switch(presentedView) {
        case let view where view == sideMenuView:
            handleXchangedForSidemenuView(newX: newX)
        case let view where view == mainTabBarView:
            handleXchangedForMainTapBarView(newX: newX)
        case let view where view == messagesView:
            handleXchangedForMessagesView(newX: newX)
        default:
            break
        }
        
        gesture.setTranslation(.zero, in: self.presentedView)
    }
    
    func handleXchangedForSidemenuView(newX: CGFloat) {
        sideMenuView.frame.origin.x = newX < 0 ? newX : 0
        mainTabBarView.frame.origin.x = newX + (mainTabBarView.frame.width * 0.8)
        messagesView.frame.origin.x = mainTabBarView.frame.origin.x + mainTabBarView.frame.width
    }
    
    func handleXchangedForMessagesView(newX: CGFloat) {
        messagesView.frame.origin.x = newX > 0 ? newX : 0
        mainTabBarView.frame.origin.x = newX - mainTabBarView.frame.width
        sideMenuView.frame.origin.x = mainTabBarView.frame.origin.x - (mainTabBarView.frame.width * 0.8)
    }
    
    func handleXchangedForMainTapBarView(newX: CGFloat) {
        var newX = newX
        let sidemenuNewX = newX - (mainTabBarView.frame.width * 0.8)
        if sidemenuNewX > 0 { // snap side menu to zero position
            newX = mainTabBarView.frame.width * 0.8
        }
        mainTabBarView.frame.origin.x = newX
        sideMenuView.frame.origin.x = newX - (mainTabBarView.frame.width * 0.8)
        messagesView.frame.origin.x = newX + mainTabBarView.frame.width
    }
    
    // MARK: - handle gesture state ended for view
    func handleHandlePanGestureStateEnded(gesture: UIPanGestureRecognizer) {
        switch(presentedView) {
        case let view where view == sideMenuView:
            handleGestureEndedForSidemenuView()
        case let view where view == mainTabBarView:
            handleGestureEndedForMainTapBarView(gesture: gesture)
        case let view where view == messagesView:
            handleGestureEndedForMessagesView()
        default:
            break
        }
    }
    
    func handleGestureEndedForSidemenuView() {
        let currentX = sideMenuView.frame.origin.x
        if abs(currentX) >= sideMenuView.frame.width / 2 {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                self.handleXchangedForMainTapBarView(newX: 0)
                self.unDimMainTapbarView()
            }, completion: { _ in
                self.presentedView = self.mainTabBarView
            })
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                self.handleXchangedForSidemenuView(newX: 0)
            }, completion: nil)
        }
    }
    
    func handleGestureEndedForMessagesView() {
        let currentX = messagesView.frame.origin.x
        if currentX >= messagesView.frame.width / 2 {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                self.handleXchangedForMainTapBarView(newX: 0)
            }, completion: { _ in
                self.presentedView = self.mainTabBarView
            })
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                self.handleXchangedForMessagesView(newX: 0)
            }, completion: nil)
        }
    }
    
    func handleGestureEndedForMainTapBarView(gesture: UIPanGestureRecognizer) {
        let currentX = mainTabBarView.frame.origin.x
        if currentX > 0 && currentX >= mainTabBarView.frame.width / 2 { // show side menu view
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                self.handleXchangedForSidemenuView(newX: 0)
                self.dimMainTapbarView()
            }, completion: { _ in
                self.presentedView = self.sideMenuView
            })
        }else if currentX < 0 && abs(currentX) >= mainTabBarView.frame.width / 2 { // show messages view
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                self.handleXchangedForMessagesView(newX: 0)
            }, completion: { _ in
                self.presentedView = self.messagesView
            })
        }
        else {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                self.handleXchangedForMainTapBarView(newX: 0)
            }, completion: nil)
        }
    }
    
    //MARK: - handle gesture state Cancelled for view
    func handleHandlePanGestureStateCancelled(gesture: UIPanGestureRecognizer) {
        switch(presentedView) {
        case let view where view == sideMenuView:
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                self.handleXchangedForSidemenuView(newX: 0)
            }, completion: nil)
        case let view where view == mainTabBarView:
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                self.handleXchangedForMainTapBarView(newX: 0)
            }, completion: nil)
        case let view where view == messagesView:
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                self.handleXchangedForMessagesView(newX: 0)
            }, completion: nil)
        default:
            break
        }
    }
    
    
    
}
