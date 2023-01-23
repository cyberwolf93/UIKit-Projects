//
//  MainContainerTransitionController.swift
//  linkedIn Replica
//
//  Created by Ahmed Mohiy on 19/01/2023.
//

import UIKit

protocol DescendantforContainerTransitionController{
    var mainContainerTransitionController: MainContainerTransitionController? {get set}
}

class MainContainerTransitionController {
    
    //MARK: Views
    var presentedView: UIView = UIView()
    var sideMenuView: UIView = UIView()
    var mainTabBarView: UIView = UIView()
    var messagesView: UIView = UIView()
    var blackView: UIView = UIView()
    
    //MARK: Variables
    var mainTabBarViewOriginalX: CGFloat {
        return 0
    }
    
    var sideMenuViewOriginalX: CGFloat {
        guard let window = UIWindow.currentWindow else {
            return 0
        }
        
        return -(window.frame.width * 0.8)
    }
    var messagesViewViewOriginalX: CGFloat {
        guard let window = UIWindow.currentWindow else {
            return 0
        }
        
        return window.frame.width
    }
    
    
    func initializeViews(sideMenuView: UIView, mainTabBarView: UIView, messagesView: UIView) {
        self.sideMenuView = sideMenuView
        self.mainTabBarView = mainTabBarView
        self.messagesView = messagesView
        self.presentedView = mainTabBarView
        self.addBlackViewToMainTapBarView()
    }
    
    //MARK: Black view to dim when main tap bar view not presented
    func dimMainTapbarView() {
        blackView.alpha = 1
    }
    
    func unDimMainTapbarView() {
        blackView.alpha = 0
    }
    func addBlackViewToMainTapBarView() {
        blackView.backgroundColor = .black.withAlphaComponent(0.4)
        blackView.frame = mainTabBarView.frame
        unDimMainTapbarView()
        mainTabBarView.addSubview(blackView)
    }

    
    // MARK: - Actions
    @objc
    func handlePanGestureRecognizer(_ gesture: UIPanGestureRecognizer) {
        guard shouldApplyTransition(with: gesture) else {
            return
        }
        
        switch (gesture.state) {
        case .began, .changed:
            handleHandlePanGestureStateChanged(gesture: gesture)
        case .ended:
            handleHandlePanGestureStateEnded(gesture: gesture)
            break
        case .cancelled:
            handleHandlePanGestureStateCancelled(gesture: gesture)
            break
        default:
            break
        }
    }
    
    @objc
    func handleProfileBarButtonClicked() {
        if presentedView == mainTabBarView {
            showSideMenuView()
        } else if presentedView == sideMenuView {
            hideSideMenuView()
        }
    }
    
    @objc
    func handleMessageBarButtonClicked() {
        if presentedView == mainTabBarView {
            showMessagesView()
        } else if presentedView == messagesView {
            HideMessagesView()
        }
    }
    
}

